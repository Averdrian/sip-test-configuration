import ESL

def handle_connection(connection):
    print("Conexión entrante de FreeSWITCH.")

    # Espera eventos y procesa la llamada
    while True:
        event = connection.recvEvent()
        if event:
            # Imprime información sobre el evento
            print(f"Evento recibido: {event.serialize('json')}")
        else:
            break

def main():
    server = ESL.ESLconnection("localhosts", "7000", "ClueCon")
    
    if server.connected():
        print("Servidor ESL escuchando en el puerto 7000...")
    else:
        print("No se pudo iniciar el servidor ESL.")
        return

    while True:
        connection = server.accept()
        if connection:
            handle_connection(connection)
        else:
            print("No se pudo aceptar la conexión.")

if __name__ == "__main__":
    main()