from flask import Flask, request, render_template
from flask_restful import Api

import os
from server.utils import get_tweets_user

app = Flask(__name__)
api = Api(app)
api.prefix = '/api'


# Endpoints______________________________________________________________________
from endpoints.predict.resource import PredictResource

api.add_resource(PredictResource, '/predict', '/predict/<user>')


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


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
