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
    create_news = "CREATE TABLE news (symbol varchar(10), title varchar(200), url varchar(200), PRIMARY KEY (title));"
    cursor.execute(create_news)
    create_stocks = "CREATE TABLE stocks ( symbol varchar(10), prices varchar(200), score varchar(200), PRIMARY KEY (symbol));"
    cursor.execute(create_stocks)

def query_results(statement, para):
    cursor.execute(statement, para)
    row = cursor.fetchone()
    res = []
    while row:
        res.append([str(item)for item in row])
        row = cursor.fetchone()
    return res

def get_stock(company):
    return query_results('SELECT * from stocks where symbol = %s', [company])


def get_predict():
    return query_results('SELECT * from stocks', [])


def get_news(company):
    return query_results('SELECT * from news where symbol = %s', [company])
   

def add_new(symbol, title, url):
    try:
        statement = 'INSERT INTO news VALUES (%s, %s, %s)'
        cursor.execute(statement, (symbol, title, url))
    except:
        pass


def add_stock(symbol, prices, score):
    try:
        statement = 'INSERT INTO stocks VALUES (%s, %s, %s)'
        cursor.execute(statement, (symbol, prices, score))
    except:
        pass


def commit():
    conn.commit()

connect()
#create_tables()
