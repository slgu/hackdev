import json
import urllib
import calendar
from datetime import datetime


# unix time,  unix time, string
def get_stock_result(start_date, end_date, symbol):
    # start_date = datetime.fromtimestamp(start).strftime('%Y-%m-%d')
    # end_date = datetime.fromtimestamp(end).strftime('%Y-%m-%d')

    url = "https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20yahoo.finance.historicaldata%20" + \
          "WHERE%20symbol%3D%22" + symbol + "%22%20and%20startDate%3D%22" + start_date + "%22%20and%20endDate%3D%22" + \
          end_date + "%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
    query = ''

    params = urllib.urlencode({
        'query': query
    })

    data = urllib.urlopen(url, params).read()
    data = json.loads(data)
    print data
    res = []
    data_node = data['query']['results']['quote']
    if type(data_node) is list:
        for daily_res in data_node:
            res.append([str_to_timestamp(daily_res['Date']), daily_res['Open'], daily_res['Close']])
    else:
        res.append([str_to_timestamp(data_node['Date']), data_node['Open'], data_node['Close']])
    return res


def str_to_timestamp(str):
    date = datetime.strptime(str, "%Y-%m-%d")
    return calendar.timegm(date.utctimetuple())


start_date_unix = "2016-02-01" #1386181800
end_date_unix = "2016-02-05" #1386281801
test_symbol = "yhoo"
#get_stock_result(start_date_unix, end_date_unix, test_symbol)