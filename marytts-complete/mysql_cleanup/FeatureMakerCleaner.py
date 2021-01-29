import os
from contextlib import contextmanager

import mysql.connector
from bs4 import BeautifulSoup
from mysql.connector import errorcode

from json_loader import read_json, write_json, get_path

"""
In step 5 we need to run the feature maker script,
this python code aims to cleanup the locale_cleanText
table before you run that as there is a lot of html
etc
"""

class FeatureCleaner:
    def __init__(self, host, port, user, password, db, table):
        self.host = host
        self.port = port
        self.user = user
        self.password = password
        self.db = db
        self.table = table

    @staticmethod
    def encode_str(item):
        """
        Simple helper method so I dont forget
        once I close the stack overflow page
        """
        return item.encode("utf-8")
    
    @staticmethod
    def decode_str(item):
        """
        See encode_str.__doc__
        """
        return item.decode("utf-8")
    
    @contextmanager
    def ensure_db_connection(self):
        """
        A context manager used to manage the database connection
        without the need to duplicate code or multiple methods
        """
        try:
            conn = mysql.connector.connect(
                host=self.host,
                port=self.port,
                user=self.user,
                password=self.password,
                database=self.db
            )

        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                raise Exception("Invalid username or password")
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                raise Exception("Unknown db")
            else:
                raise err
        
        else:
            cursor = conn.cursor()
        
        yield cursor

        cursor.close()

        conn.commit()
        conn.close()
    
    def write_table_to_json(self):
        """
        Will write the entirety of 
        self.table into a 'words.json' file
        """
        with self.ensure_db_connection() as cursor:
            # Note to self, cursor is lazily executed
            query = f"SELECT * FROM {self.table}"
            cursor.execute(query)

            # Idea being work with em in json cos easier
            data = {}

            for (id, cleanText, processed, page_id, text_id) in cursor:
                cleanText = self.decode_str(cleanText)
                data[cleanText] = {"id": id, "processed": processed, "page_id": page_id, "text_id": text_id}

            write_json(data, "FeatureMakerAssets/db")
    
    def remove_html(self):
        """
        Attempt to detect html 'cleanText'
        and remove it all
        """
        data = read_json("FeatureMakerAssets/db")
        if data == {}:
            self.write_table_to_json()
        
        to_remove = []

        for item in data.keys():
            # Check agaisnt html
            is_html = bool(BeautifulSoup(item, "html.parser").find())
            if is_html:
                to_remove.append(item)
                continue
            
            # Attempt to remove any scripts n such not caught by bs4
            is_js = "document.get" in item.lower()
            if is_js:
                to_remove.append(item)
                continue
        
        for key in to_remove:
            data.pop(key)
        
        write_json(data, "FeatureMakerAssets/db")
        print("Please go through the json file now and remove all entries you don't consider to be 'Maori enough'. Done: Y|N")
        input()
    
    def rewrite_table(self):
        """
        Override the database table with the now only maori cleantext
        """
        with self.ensure_db_connection() as cursor:
            create_placeholder = f"CREATE TABLE placeholder LIKE {self.table}"
            cursor.execute(create_placeholder)

    
            create_table = create_placeholder = f"CREATE TABLE {self.table} LIKE placeholder"
            cursor.execute(create_table)

            drop_placeholder = "DROP TABLE placeholder"
            cursor.execute(drop_placeholder)

            data = read_json("FeatureMakerAssets/db")
            for key, value in data.items():
                query = f"INSERT INTO {self.table} (cleanText, processed, page_id, text_id) VALUES (%s, 0, %s, %s)"
                val = (self.encode_str(key), value['page_id'], value["text_id"])
                cursor.execute(query, val)

if __name__ == "__main__":
    port = 6606
    host = "localhost"
    user = "mary"
    password = "wiki123"
    db = "wiki"
    table = "mi_cleanText"

    # Run this for before step 5
    feature_cleaner = FeatureCleaner(host, port, user, password, db, table).rewrite_table()

    # TODO Manually craft sentences from mi_dbselection and move them to mi_text_cleanSentences