from flask import Flask, render_template, request
from flask_restful import Resource, Api


app = Flask(__name__)
api = Api(app)


class GetSummary(Resource):
    def post(self):
        print(request.get_json(force=True))
        return {"status": "success"}


@app.route("/")
def root():
    return render_template("index.html")


api.add_resource(GetSummary, "/summarypost")


if __name__ == "__main__":
    app.run(host="127.0.0.1", port="5000", debug=True)
