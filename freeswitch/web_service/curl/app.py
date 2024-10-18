from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/', methods=["GET","POST"])
def process():
    print(request.get_data())
    print("Hola mundo")
    return jsonify({}, 200)



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000)