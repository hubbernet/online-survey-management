import requests
from flask import Flask, render_template, request, jsonify, json
app = Flask(__name__)


@app.route("/survey", methods=["GET"])
def survey():
    return render_template('index.html')


@app.route("/handle", methods=["POST"])
def handle():
    res = request.form.to_dict()
    res_json = json.dumps(res)
    r = requests.post("http://localhost:6464/",
                      data=res_json,
                      headers={
                          'Content-Type': 'application/json; charset=UTF-8'
                      })
    return render_template("survey.html")


if __name__ == "__main__":
    app.run(debug=True)
