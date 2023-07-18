from flask import Flask, render_template, request

app=Flask(__name__)

@app.route("/hello")
def hello():
    return "hello world"

@app.route("/")
def index0():
	return render_template("0_template.html")

@app.route("/1_js")
def index1():
	return render_template("1_js.html")

@app.route("/2_jquery")
def index2():
	return render_template("2_jquery.html")

@app.route("/3_ajax")
def index3():
	return render_template("3_ajax.html")

@app.route("/ans")
def ans():
	return render_template("ans.html")

@app.route("/testpost", methods = ['POST'])
def testpost():
    obj = request.get_json()
    print(obj["name"])
    return {"status": "success"}

@app.route("/testformpost", methods = ['POST'])
def testformpost():
    print(request)
    obj = request.get_json()
    print(obj)
    return {"status": "success"}

@app.route("/adderResult", methods = ["POST"])
def adderResult():
	print("--------------------------------------------------------------------------")
	print(request.get_json())
	print(request.get_data())
	print("--------------------------------------------------------------------------")


if __name__ == "__main__":
	app.run(host="127.0.0.1", port="5000",debug=True)