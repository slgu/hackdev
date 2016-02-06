import requests
import urllib2
from datetime import datetime


def search_news(company, date):
    date = datetime.strptime(date, "%Y-%m-%d")
    QUERY_URL = 'https://api.datamarket.azure.com/Bing/Search/News' + '?Query={}&$top={}&$skip={}&$format={}&NewsSortBy=%27Date%27'
    API_KEY = "aXhVYrh/6fy19csXteZVZ70HtS88vP194vWGijHw6s0"
    limit = 10
    offset = 0 
    format = "json"
    url = QUERY_URL.format(urllib2.quote("'{}'".format(company)), limit, offset, format)
    r = requests.get(url, auth=("", API_KEY))
    try:
        json_results = r.json()
    except Exception as e:
        print Exception
    res = []
    for result in json_results['d']['results']:
        d = datetime.strptime(result['Date'], "%Y-%m-%dT%H:%M:%SZ")
        if d > date:
            url = result['Url']
            title = result['Title'].replace(u'\xa3', '').replace(u"\u2018", '').replace(u"\u2019", '').replace(u'\u20ac', '').replace(u'\u201c', '').replace(u'\u201d', '').replace(u'\u2013', '').replace('\'', '').replace('"', '')
            desc = result['Description'].replace(u'\xa3', '').replace(u"\u2018", '').replace(u"\u2019", '').replace(u'\u20ac', '').replace(u'\u201c', '').replace(u'\u201d', '').replace(u'\u2013', '').replace('\'', '').replace('"', '')
            res.append([title, desc, url])
    return res


# print search_news("google", "2016-2-6")
