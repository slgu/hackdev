from bing_search import *
from alchemy_util import *
from yahoo_util import *
from database_util import *
import time

company_list = {'Google': 'GOOGL', 'Facebook': 'FB', 'Microsoft': 'MSFT', 'LinkedIn': 'LNKD', 'Control4 Corporation': 'CTRL'}
high_threshold = 0.5
low_threshold = -0.5


def main():
    connect()
    start_date = "2016-01-27"
    end_date = "2016-02-05"
    for company in company_list:
        news = search_news(company, "2016-02-05")
        titles = ''
        for new in news:
            titles += ' ' + new[0]
        score = get_sentiment(titles)
        print score
        if score > high_threshold or score < low_threshold:
            for new in news:
                add_new(company_list[company], new[0], new[2])
                time.sleep(1)
            stock = get_stock_result(start_date, end_date, company_list[company])
            add_stock(company_list[company], ','.join([item[1] for item in stock]), score)
            print company_list[company], score, stock
    commit()
main()