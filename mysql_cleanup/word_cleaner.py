import os
from contextlib import contextmanager

import mysql.connector
from mysql.connector import errorcode

from json_loader import read_json, write_json, get_path


class WordCleaner:
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
                host=host,
                port=port,
                user=user,
                password=password,
                database=db
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

            for (id, word, usages) in cursor:
                word = self.decode_str(word)
                data[word] = {"id": id, "usages": usages}

            write_json(data, "words")
    
    def json_to_txt(self):
        """
        Given the json file exists, make a 
        txt file of all of the words
        """
        data = read_json("words")
        if data == {}:
            self.write_table_to_json()
        
        all_words = ""
        for word in data.keys():
            all_words += f"{word}\n"
        all_words.rsplit("\n")

        with open("words.txt", 'w') as f:
            f.write(all_words)
    
    def convert_to_maori(self):
        """
        Given the textfile of all words,
        call the nga-kupu script to 
        get only the maori words
        """
        cwd = get_path()
        print(cwd)
        if not os.path.exists(f"{cwd}/maori.txt"):
            self.json_to_txt()
        
        if not os.path.exists(f"{cwd}/maori.txt"):
            print("Please run the following command in a terminal before continuing")
            print(f"python3 {cwd}/nga-kupu/scripts/kupu_tūtira -i words.txt -o maori.txt")
            input()
    
    def maori_words_to_json(self, steps=0):
        """
        Overriding our words.json file, 
        recreate it but with only maori
        words this time
        """
        cwd = get_path()
        if not os.path.exists(f"{cwd}/maori.txt"):
            self.convert_to_maori()
        
        with open(f"{cwd}/maori.txt", 'r') as f:
            content = f.read()
            content = content.splitlines()
        
        old_data = read_json("words")
        data = {}

        for word in content:
            try:
                data[word] = old_data[word]
            except KeyError:
                pass
        
        if len(old_data) == len(data) and steps == 0:
            # This ensures we actually doing it right
            # since we want the entire dataset 
            self.write_table_to_json()
            self.maori_words_to_json(steps=1)

        write_json(data, "words")

    def update_table_with_maori(self):
        """
        Replace the existing table with 
        the all maori dataset
        """
        self.maori_words_to_json()

        with self.ensure_db_connection() as cursor:
            create_placeholder = f"CREATE TABLE placeholder LIKE {self.table}"
            cursor.execute(create_placeholder)

            drop_table = f"DROP TABLE {self.table}"
            cursor.execute(drop_table)

            create_table = create_placeholder = f"CREATE TABLE {self.table} LIKE placeholder"
            cursor.execute(create_table)

            drop_placeholder = "DROP TABLE placeholder"
            cursor.execute(drop_placeholder)

            data = read_json("words")
            for key, value in data.items():
                query = f"INSERT INTO {self.table} (word, frequency) VALUES (%s, %s)"
                val = (self.encode_str(key), value['usages'])
                cursor.execute(query, val)
    
    def run(self):
        self.update_table_with_maori()


if __name__ == "__main__":
    port = 6606
    host = "localhost"
    user = "mary"
    password = "wiki123"
    db = "wiki"
    table = "mi_wordList"

    word_cleaner = WordCleaner(host, port, user, password, db, table).run()
    