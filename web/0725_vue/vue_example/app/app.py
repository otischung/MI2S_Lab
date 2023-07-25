
from flask import Flask, render_template, request

class VueFlask(Flask):
    jinja_options = Flask.jinja_options.copy()
    # Default is "{{ }}", changing to "%% %%"
    jinja_options.update(dict(variable_start_string="%%",
                              variable_end_string="%%"))
app=VueFlask(__name__)



# from flask_cors import CORS
# CORS(app, resources={r"/*": {"origins": "*"}})


@app.route("/")
def hello():
	return render_template("0_template.html", message_jinja = "hello jinja")

@app.route("/1_jinja_vue")
def index1():
	return render_template("1_jinja_vue.html", message_jinja = "P76124605")

@app.route("/2_vue_variable")
def index2():
	return render_template("2_vue_variable.html")
    
@app.route("/3_vue_flow")
def index3():
	return render_template("3_vue_flow.html")

@app.route("/4_vue_axios")
def index4():
	return render_template("4_vue_axios.html")

@app.route("/test/get", methods = ["GET"])
def test_get():
    yorn = request.args.get("yorn")
    print(yorn)
    if yorn == "y":
        result = {
            "status": "success"
        }
    else:
        result = {
            "status": "fail"
        }
    return result

@app.route("/test/post", methods = ["POST"])
def test_post():
    data = request.get_json()
    yorn = data["yorn"]
    print(yorn)
    if yorn:
        result = {
            "status": "success"
        }
    else:
        result = {
            "status": "fail"
        }
    return result

@app.route("/test/init", methods = ["GET"])
def test_init():
    import time
    time.sleep(3)
    result = {
        "status": "success",
        "data": "init success"
    }
    return result

if __name__ == "__main__":
	app.run(host="127.0.0.1", port="5000",debug=True)