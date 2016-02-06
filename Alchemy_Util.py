import json
import urllib


def get_sentiment(text):
    text = text.replace(u"\u2018", '').replace(u"\u2019", '').replace(u'\u20ac', '')
    url = "http://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment"
    key = "9f99564afa14defdd7210ba7d9767f41ddb084a9"
    params = urllib.urlencode({
        'apikey': key,
        'text': text,
        "outputMode": 'json'
    })

    data = urllib.urlopen(url, params).read()
    res = json.loads(data)
    if 'score' in res['docSentiment']:
        return float(res['docSentiment']['score'])
    else:
        return 0.0
