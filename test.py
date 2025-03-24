import socket
import sys

def send_string_over_tcp(host, port, message):
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((host, port))
            s.sendall(message.encode())
            print("Message sent successfully!")
    except Exception as e:
        print(f"Error: {e}")

host = 'localhost' 
port = 1004 

message = f'{sys.argv[1]}'

send_string_over_tcp(host, port, message)