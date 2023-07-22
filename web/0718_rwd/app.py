from flask import Flask, render_template, request, jsonify
# from flask_api import status
from flask_restful import Resource, Api
import summary_client


app = Flask(__name__)
api = Api(app)


class GetSummary(Resource):
    def post(self):
        # Text from POST
        req_json = request.get_json(force=True)
        text = req_json["input"]
        category = req_json["radios"][0]
        summary = ""
        try:
            summary = summary_client.summary_news(str(text), category)
        except ConnectionRefusedError:
            app.logger.error("FATAL ERROR: Connection Refused.")
            return {"status": "fail"}, 500
        return jsonify({
            "status": "success",
            "summary": summary
        })


@app.route("/")
def root():
    return render_template("index.html")


api.add_resource(GetSummary, "/summarypost")


if __name__ == "__main__":
    app.run(host="127.0.0.1", port="5000", debug=True)
