import os
from contextlib import contextmanager

import mysql.connector
from mysql.connector import errorcode

from json_loader import read_json, write_json, get_path


class DatabaseSelector:
    def __init__(self, host, port, user, password, db, final_table, word_table):
        """
        final_table is where to move snetences to
        word_table is where the sentences currently are

        the rest are mysql params
        """
        self.host = host
        self.port = port
        self.user = user
        self.password = password
        self.db = db
        self.final_table = final_table
        self.word_table = word_table

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
    
    def database_sentence_transfer(self):
        """
        Transfer all sentences from mi_dbselection over to mi_test_selectedSentences
        while preserving how Mary would work with the data
        """
        with self.ensure_db_connection() as cursor:
            # Remake the table, just so its empty and we dont have to care
            create_placeholder = f"CREATE TABLE placeholder LIKE {self.final_table}"
            cursor.execute(create_placeholder)

            drop_table = f"DROP TABLE {self.final_table}"
            cursor.execute(drop_table)

            create_table = create_placeholder = f"CREATE TABLE {self.final_table} LIKE placeholder"
            cursor.execute(create_table)

            drop_placeholder = "DROP TABLE placeholder"
            cursor.execute(drop_placeholder)

        with self.ensure_db_connection() as cursor:
            # Actually move sentences over
            get_sentences = f"SELECT id, sentence FROM {self.word_table}"
            cursor.execute(get_sentences)
            sentences = list(cursor)

            for (db_selection_id, sentence) in sentences:
                query = f"INSERT INTO {self.final_table} (sentence, unwanted, dbselection_id) VALUES (%s, 0, %s)"
                val = (sentence, db_selection_id)
                cursor.execute(query, val)
        
        with self.ensure_db_connection() as cursor:
            # Update the word_table so all words are marked as selected (1, I think)
            query = f"UPDATE {self.word_table} SET selected = 1"
            cursor.execute(query)
            


            


if __name__ == "__main__":
    port = 6606
    host = "localhost"
    user = "mary"
    password = "wiki123"
    db = "wiki"
    final_table = "mi_test_selectedSentences"
    word_table = "mi_dbselection"

    # Run step 6, then run this
    db_selector = DatabaseSelector(host, port, user, password, db, final_table, word_table).database_sentence_transfer()

