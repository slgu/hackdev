import pymssql

srv = 'stockhunter.database.windows.net'
db = 'StockHunter'
conn = pymssql.connect(server=srv, user='test@stockhunter', password='pass123!', database=db)
cursor = conn.cursor()
cursor.execute('SELECT * from news')
row = cursor.fetchone()
while row:
    print row
    row = cursor.fetchone()