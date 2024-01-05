import mysql.connector
from datetime import datetime

# database connection configuration
db_connection = mysql.connector.connect(
    host="host", 
    user="user", 
    passwd="password", 
    database="db2_industries_schema"
)

# try-finally block used so if an error occurs
# the database connection is always closed
try:
    # cursor object required to perform database operation
    cursor = db_connection.cursor()
    # performing sql query to fetch all records in Companies table
    cursor.execute("SELECT * FROM Companies")
    results = cursor.fetchall()

    # retrieving column names from table
    column_names = [i[0] for i in cursor.description]

    # getting current time to concatenate to filename, ensuring uniqueness
    current_dateTime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    file_name = f'backup_{current_dateTime}.txt'

    # creating and opening new file in write mode
    with open(file_name, "w") as f:
        # writing first line in file as list of column names in table
        f.write(', '.join(map(str, column_names)) + '\n')

        # converting row to a string and writing to file.
        for row in results:
            f.write(', '.join(map(str, row)) + '\n')

    # closing file connection
    f.close()

finally:
    if db_connection.is_connected():
        # closing sql database connection
        cursor.close()
        db_connection.close()