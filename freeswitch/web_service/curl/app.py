from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=["GET","POST"])
def process():
    print(request.get_data())
    print("Hola mundo")
    print(request.keys())
    return 'Bueno dia mundo'



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000)
    
# import ESL

# def handle_connection(conn):
#     print("Conexión entrante de FreeSWITCH.")
#     while True:
#         e = conn.recvEvent()
#         if e:
#             print(f"Evento recibido: {e.serialize('json')}")
#         else:
#             break

# def main():
#     server = ESL.ESLsocket()
#     if server.listen('0.0.0.0', 7000):
#         print("Servidor ESL escuchando en el puerto 7000...")
#     else:
#         print("No se pudo iniciar el servidor ESL.")
#         return

#     while True:
#         conn = server.accept()
#         if conn:
#             handle_connection(conn)
#         else:
#             print("No se pudo aceptar la conexión.")

# if __name__ == "__main__":
#     main()
