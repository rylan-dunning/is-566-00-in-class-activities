import psycopg2

def load_asset_data(record_to_load,
                    host = 'postgres'):
    
    try:
        connection = psycopg2.connect(user="airflow",
                                    password="airflow",
                                    host=host,
                                    port="5432",
                                    database="airflow")
        cursor = connection.cursor()

        # Placeholder query logic
        postgres_insert_query = """INSERT INTO cryptodata.assets (id) 
                                            VALUES (%s);"""
        record_to_insert = (record_to_load["id"])
        cursor.execute(postgres_insert_query, record_to_insert)

        connection.commit()
        count = cursor.rowcount
        print(count, "Record inserted successfully into table")

    except (Exception, psycopg2.Error) as error:
        
        print("Failed to insert record into table", error)
        
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
        
        raise Exception(error)

    finally:
        # closing database connection.
        if connection is not None:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")