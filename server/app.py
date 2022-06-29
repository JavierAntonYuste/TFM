import json
from flask import Flask, request, render_template, make_response
from requests import Response
from flask_restful import Api

import os
from utils import get_prediction, test

app = Flask(__name__)
api = Api(app)
api.prefix = '/api'


# Endpoints______________________________________________________________________
# from endpoints.predict.resource import PredictResource
# from endpoints.mlpredict.resource import PredictResourceML


# api.add_resource(PredictResource, '/predict', '/predict/<user>')
# api.add_resource(PredictResourceML, '/predictml', '/predictml/<user>')



# Routes

@app.route('/')
def index():
	#"""Homepage"""
    return render_template('index.html')

@app.route('/', methods=['POST'])
def results():
	#"""Show dataframe and results"""
    text = request.form['text']
    processed_text = text.lower()
    df=get_tweets_user(processed_text)
    return render_template('results.html',tables=[df.to_html(classes='data')], titles=df.columns.values)

@app.route('/predict/<username>')
def predict(username):
    #"""Predict"""
    #resp = Response(json.dumps(get_tweets_user(username)))
    resp = make_response(json.dumps(get_prediction(username)))
    resp.headers['Access-Control-Allow-Origin'] = '*'

    return resp

@app.route('/test')
def testing():
    #"""Predict"""
    #resp = Response(json.dumps(get_tweets_user(username)))
    resp = make_response(json.dumps(test('Jabubu_')))
    resp.headers['Access-Control-Allow-Origin'] = '*'

    return resp



if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
