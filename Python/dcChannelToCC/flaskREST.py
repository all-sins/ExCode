from flask import Flask, request, jsonify

app = Flask(__name__)
messages = []

@app.route('/post_message', methods=['POST'])
def post_message():
    content = request.json
    messages.append(content["message"])
    return jsonify(success=True)

@app.route('/get_messages', methods=['GET'])
def get_messages():
    if messages:
        return jsonify(messages.pop(0))
    return jsonify("No new messages")

app.run(host='0.0.0.0', port=5000)
