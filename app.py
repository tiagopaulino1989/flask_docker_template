from flask import Flask, request, jsonify, json
from flask_cors import CORS, cross_origin

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

@app.route("/")
def index():
    return json.dumps({"status":'Online'})
