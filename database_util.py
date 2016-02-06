import pymssql
import MySQLdb

conn = None
cursor = None


def connect():
    global conn
    global cursor
    srv = '127.0.0.1' #'stockhunter.database.windows.net'
    database = 'StockHunter'
    usr = 'root' #'test@stockhunter'
    psw = '' #'pass123!'
    # conn = pymssql.connect(server=srv, user=usr, password=psw, database=db)
    conn = MySQLdb.connect(srv, usr, psw, database)
    cursor = conn.cursor()


def get_stock(company):
    cursor.execute('SELECT * from ' + 'stocks')
    row = cursor.fetchone()
    while row:
        print row
        row = cursor.fetchone()


def get_news(company):
    cursor.execute('SELECT * from ' + 'news')
    row = cursor.fetchone()
    while row:
        print row
        row = cursor.fetchone()


def add_new(symbol, title, url):
    statement = 'INSERT INTO news VALUES (\'' + symbol + '\', \'' + title + '\', \'' + url + '\')'
    print statement
    cursor.execute(statement)


def add_stock(symbol, prices):
    statement = 'INSERT INTO stocks VALUES (\'' + symbol + '\', \'' + prices + '\')'
    print statement
    cursor.execute(statement)

connect()