import socket
import threading
import sys
import time
import atexit
import re


ephestos_running = False
thread_created = False
threadSocket = 0
socketServer = 0
receivedSocket = "none"
listening = False
socketMessages = []
shutDown = False
receivedData = ''
pherror = [""]
alogging = True

def initialize_server():
    if alogging:
        print("initializing server")

    global threadSocket,listening
    #threadSocket = threading.Thread(name='threadSocket', target= socket_listen)
    listening = True

    if alogging:
        print("calling create_socket_connection")

    create_socket_connection()
    socket_listen()
    #threadSocket.start()


def socket_listen():
    global receivedSocket,listening, receivedData,socketServer, socketMessages, pherror
    socketServer.listen(5)


    while listening:
        (receivedSocket , adreess) = socketServer.accept()
        receivedData = (receivedSocket.recv(1024)).decode("utf-8")[:-2]


        socketMessages.append(receivedData)
        time.sleep(0.03)
        handle_messages()

        if alogging:
            print("pherror : " ,pherror)


        while not (pherror[-1]==""):

            receivedSocket.sendall((pherror[-1]+'\n').encode())
            if alogging:
                print("I have sent err : --->"+ pherror[-1] + ' <---- and removed it from the list of errors')

            if len(pherror) > 1:pherror.remove(pherror[-1])


            receivedSocket.sendall("end of error\n".encode())
       # receivedSocket.close()

def create_socket_connection():
    global socketServer, shutDown
    socketServer = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socketServer.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    socketServer.bind(('127.0.0.1',4000))




def handle_messages():
    global ephestos_running, thread_created, listening, socketServer, socketMessages, pherror, shutDown

    for msg in socketMessages:
        try:
            if "RetValue:" in msg:
                regexobj = re.compile("[^(RetValue:)]\S.*")
                regexsearch = regexobj.search(msg)
                pythoncomm = regexsearch.group(0)
                pherror.append("RetValue:"+str(eval(pythoncomm)))
                #pherror.append("no error\n")

                if alogging:
                    print("eval with pherror: ",pherror)

            elif "exit" in msg:
                pherror.append("no error\n")
                shutDown=True
            else:
                exec(msg,globals())
                pherror.append("no error\n")
        except Exception as e:
            newerror = "Error:" +str(e)+" with :" + msg
            pherror.append( newerror )
            if alogging:
                print( "inserted an error now pherror : ",pherror)

            #socketMessages.remove(msg)
        socketMessages.remove(msg)

    if shutDown:
        ephestos_running = False
        listening = False

        socketServer.settimeout(0.01)
        socketServer.close()
        time.sleep(1)

        #threadSocket.join()
        del socketServer

        thread_created = False
        shutDown = False



def initAtlas():

    #anotherThread = threading.Thread(target=another_thread)
    #anotherThread.start()

    initialize_server()




if __name__ == "__main__":
    initAtlas()
