#!/bin/env python
# coding=utf-8
#     File Name: web_service.py
#     Author: Gu Shenlong
#     Mail: blackhero98@gmail.com
#     Created Time: Fri Feb  5 18:17:10 2016


import sys,os,math,time,logging,json

import tornado.ioloop
import tornado.web
import json
import database_util as db

def check_double(date):
    if date == None:
        return None
    try:
        unix_time_stamp = float(date[0]) 
    except:
        return None
    return unix_time_stamp
        

def test_news_get():
    target = []
    arr = {}
    arr["title"] = "fuck linkedin"
    arr["url"] = "http://www.google.com"
    target.append(arr)
    arr = {}
    arr["title"] = "hahha this linkedin"
    arr["url"] = "http://www.google.com"
    target.append(arr)
    return json.dumps(target)

class NewsGetter(tornado.web.RequestHandler):
    def get(self):
        unix_time = check_double(self.get_arguments("datetime"))
        if unix_time == None:
            self.write(json.dumps([]))
            return
        company_name = self.get_arguments("company_name")
        if company_name == None:
            self.write(json.dumps([]))
            return
        company_name = company_name[0]
        stocks_res = db.get_stock(company_name)
        news_res = db.get_news(company_name)

        mp = {}
        mp["company_name"] = company_name
        mp["stock_value"] = stocks_res[0][1]
        mp["news"] = [{"title":item[1], "url":item[2]} for item in news_res]
        #return format {"company_name": "stock_value":[], "news":["title": "url"]"}"
        print mp
        self.write(json.dumps(mp))

         
def test_predict_return():
    target = []
    arr = {}
    arr["company_name"] = "GOOGLE"
    arr["pos_neg_value"] = 0.45
    target.append(arr)
    arr = {}
    arr["company_name"] = "GOOGLE"
    arr["pos_neg_value"] = 0.45
    target.append(arr)
    arr = {}
    arr["company_name"] = "LINKEDIN"
    arr["pos_neg_value"] = -0.15
    target.append(arr)
    return json.dumps(target)

class PredictPush(tornado.web.RequestHandler):
    def get(self):
        unix_time = check_double(self.get_arguments("datetime"))
        if unix_time == None:
            self.write(json.dumps([]))
            return
        res = db.get_predict()
        #return format {"company_name":"", "pos_neg_value":} 
        #add empty things
        hash_arr = [{"company_name":"","pos_neg_value":1.0}]
        hash_arr += [{"company_name":str(item[0]), "pos_neg_value":float(item[2])} for item in res]
        self.write(json.dumps(hash_arr)) 
            


def make_app():
    return tornado.web.Application([
        (r"/news/get", NewsGetter),
        (r"/predict/push", PredictPush), 
    ])

if __name__ == "__main__":
    app = make_app()
    app.listen(8888)
    tornado.ioloop.IOLoop.current().start()

