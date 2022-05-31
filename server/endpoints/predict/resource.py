import json
from flask_restful import Resource, reqparse, request
from utils import get_tweets_user

class PredictResource(Resource):
    def get(self, user=None):
        # response.headers["Access-Control-Allow-Origin"] = "*"
        # response.headers["Access-Control-Allow-Headers"] = "*"
        # response.headers["Access-Control-Allow-Methods"] = "*"
        # response.headers["Access-Control-Allow-Credentials"] = "true"


        if user:
            return json.dumps(get_tweets_user(user))
        else:
            return {'hello': 'world'}