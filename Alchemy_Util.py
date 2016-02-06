import json
import urllib


def get_sentiment(text):

    url = "http://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment"
    key = "9f99564afa14defdd7210ba7d9767f41ddb084a9"

    params = urllib.urlencode({
        'apikey': key,
        'text': text,
        "outputMode": 'json'
    })

    data = urllib.urlopen(url, params).read()
    res = json.loads(data)
    return res['docSentiment']['score']


test_text = 'LinkedIn has bad season report'
print get_sentiment(test_text)
