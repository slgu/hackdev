import pymssql
import _mysql


conn = None
cursor = None


def connect():
    global conn
    global cursor
    srv = 'stockhunter.csfqneogzevi.us-west-2.rds.amazonaws.com:3306' #'stockhunter.database.windows.net'
    database = 'StockHunter'
    usr = 'test' #'test@stockhunter'
    psw = 'pass123!' #'pass123!'
    # conn = pymssql.connect(server=srv, user=usr, password=psw, database=db)
    conn = _mysql.connect(host=srv,user=usr,
                  passwd=psw,db=database)
    cursor = conn.cursor()

def create_tables():
    pass
def query_results(statement):
    cursor.execute(statement)
    row = cursor.fetchone()
    res = []
    while row:
        res.add([str(item)for item in row])
        row = cursor.fetchone()
    return res

def get_stock(company):
    query_results('SELECT * from ' + 'stocks' + 'where symbol = ' + company)


def get_predict():
    query_results('SELECT * from ' + 'stocks')


def get_news(company):
    query_results('SELECT * from ' + 'news' + 'where news = ' + company)
   

def add_new(symbol, title, url):
    statement = 'INSERT INTO news VALUES (\'' + symbol + '\', \'' + title + '\', \'' + url + '\')'
    print statement
    cursor.execute(statement)


def add_stock(symbol, prices):
    statement = 'INSERT INTO stocks VALUES (\'' + symbol + '\', \'' + prices + '\')'
    print statement
    cursor.execute(statement)

connect()
