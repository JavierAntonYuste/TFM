from flask_restful import Resource, reqparse, request
from utils import get_tweets_user

class PredictResource(Resource):
    def get(self, user=None):
        if user:
            return get_tweets_user_ml(user).to_json()
        else:
            return {'hello': 'world'}