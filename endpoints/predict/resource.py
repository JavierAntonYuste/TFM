from flask_restful import Resource, reqparse, request
from utils import getTweetsUser

class PredictResource(Resource):
    def get(self, user=None):
        if user:
            return getTweetsUser(user).to_json()
        else:
            return {'hello': 'world'}