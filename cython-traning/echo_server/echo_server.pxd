cdef extern from "arpa/inet.h":
    cdef enum:
        INET_ADDRSTRLEN
        INET6_ADDRSTRLEN

    int htons (int)
    int htonl (int)
    int ntohl (int)
    int ntohs (int)

cdef extern from "sys/socket.h":
    int AF_INET
    int SOCK_STREAM, INADDR_ANY

    int socket "socket"(int domain, int type, int protocol)

    ctypedef unsigned int sa_family_t
    ctypedef unsigned int in_port_t
    ctypedef unsigned int in_addr_t
    ctypedef unsigned int socklen_t

    cdef struct in_addr:
        in_addr_t s_addr

    cdef struct sockaddr:
        unsigned char sa_len
        sa_family_t sa_family
        char sa_data[250]

    cdef struct sockaddr_in:
        unsigned char sin_len
        sa_family_t sin_family
        in_port_t sin_port
        in_addr sin_addr
        char sin_zero[8]

    int accept (int fd, sockaddr *addr, socklen_t *addr_len)
    int bind   (int socket, sockaddr *address, socklen_t addr_len)
    int listen (int fd, int backlog)
    int close  (int fd)

cdef extern from "unistd.h":
    size_t write (int fd, char *buf, size_t nbytes)
    size_t read  (int fd, char *buf, size_t nbytes)

cdef extern from "sys/select.h":
    cdef struct timeval:
        long tv_sec
        long tv_usec

    ctypedef void *fd_set
    void FD_CLR(int fd, fd_set *set)
    bint FD_ISSET(int fd, fd_set *set)
    void FD_SET(int fd, fd_set *set)
    void FD_ZERO(fd_set *set)
    int FD_SETSIZE

    int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, timeval *timeout)
