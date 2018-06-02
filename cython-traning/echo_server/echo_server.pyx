cdef c_echo_server(unsigned short port):
    cdef int clientlen
    cdef int sock
    cdef int new_sock
    cdef char buf[100]
    cdef size_t size
    cdef sockaddr_in addr
    addr.sin_family      = AF_INET
    addr.sin_addr.s_addr = htonl(INADDR_ANY)
    addr.sin_port        = htons(port);
    clientlen = sizeof(addr)
    sock = socket(AF_INET, SOCK_STREAM, 0)
    bind(sock, <sockaddr*>&addr, sizeof(addr))
    listen(sock, 5)
    new_sock = accept(sock, <sockaddr*>&addr, <socklen_t*>&clientlen)
    while 1:
        size = read(new_sock, buf, 100)
        if size <= 0:
            close(new_sock)
        else:
            write(new_sock, buf, size)

def run(unsigned short port):
    return c_echo_server(port)
