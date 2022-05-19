class HelloWorld(Resource):
    def get(self):
        return {'hello': 'world'}