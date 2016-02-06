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
        
        #return format {"title":"", "url":"", "desc":"", "date":""} 
        self.write(test_news_get())

         
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
        #return format {"company_name":"", "pos_neg_value":} 
        self.write(test_predict_return()) 
    


def make_app():
    return tornado.web.Application([
        (r"/news/get", NewsGetter),
        (r"/predict/push", PredictPush), 
    ])

if __name__ == "__main__":
    app = make_app()
    app.listen(8888)
    tornado.ioloop.IOLoop.current().start()

