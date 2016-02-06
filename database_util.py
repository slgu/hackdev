import pymssql
import MySQLdb


conn = None
cursor = None


def connect():
    global conn
    global cursor
    srv = 'stockhunter.csfqneogzevi.us-west-2.rds.amazonaws.com' #'stockhunter.database.windows.net'
    database = 'StockHunter'
    usr = 'test' #'test@stockhunter'
    psw = 'pass123!' #'pass123!'
    # conn = pymssql.connect(server=srv, user=usr, password=psw, database=db)
    conn = MySQLdb.connect(host=srv,user=usr,passwd=psw,db=database)
    cursor = conn.cursor()

def create_tables():
    create_news = "CREATE TABLE news (symbol varchar(10), title varchar(200), url varchar(200));"
    cursor.execute(create_news)
    create_stocks = "CREATE TABLE stocks ( symbol varchar(10), prices varchar(200), score varchar(200));"
    cursor.execute(create_stocks)

def query_results(statement):
    cursor.execute(statement)
    row = cursor.fetchone()
    res = []
    while row:
        res.add([str(item)for item in row])
        row = cursor.fetchone()
    return res

def get_stock(company):
    return query_results('SELECT * from ' + 'stocks' + 'where symbol = ' + company)


def get_predict():
    return query_results('SELECT * from ' + 'stocks')


def get_news(company):
    return query_results('SELECT * from ' + 'news' + 'where news = ' + company)
   

def add_new(symbol, title, url):
    statement = 'INSERT INTO news VALUES (\'' + symbol + '\', \'' + title + '\', \'' + url + '\')'
    print statement
    cursor.execute(statement)


def add_stock(symbol, prices):
    statement = 'INSERT INTO stocks VALUES (\'' + symbol + '\', \'' + prices + '\')'
    print statement
    cursor.execute(statement)

connect()
#create_tables()
