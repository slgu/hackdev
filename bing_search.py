#!/bin/env python
# coding=utf-8
#     File Name: bing_search.py
#     Author: Gu Shenlong
#     Mail: blackhero98@gmail.com
#     Created Time: Fri Feb  5 17:35:09 2016


import sys,os,math,time,logging,json

import requests
import urllib2
QUERY_URL = 'https://api.datamarket.azure.com/Bing/Search/News' + '?Query={}&$top={}&$skip={}&$format={}'

def fetch(query):
    API_KEY = "aXhVYrh/6fy19csXteZVZ70HtS88vP194vWGijHw6s0"
    limit = 10
    offset = 0 
    format = "json"
    url = QUERY_URL.format(urllib2.quote("'{}'".format(query)), limit, offset, format)
    print url
    r = requests.get(url, auth=("", API_KEY))
    try:
        json_results = r.json()
    except Exception as e:
        print "format json error"
    for result in json_results['d']['results']:
        url = result['Url']
        title = result['Title']
        desc = result['Description']
        id = result['ID']
        print url, title, desc, id

if __name__ == "__main__":
    fetch("google") 
