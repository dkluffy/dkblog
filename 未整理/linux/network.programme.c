1.TCP
Server: socket ->bind ->listen ->accept
        read(),write()
Client: socket ->connect
        read(),write()
2.UDP
Server: socket ->bind ->recvfrom
        sendto
Client: socket ->bind ->sendto
        recvfrom

----DES IN C:
Family:
AF_INET IPv4
AF_INET6 IPv6
AF_LOCAL UNIX DOMAIN
AF_ROUTE Route sockets
AF_KEY  key sockets

TYPE:
SOCK_STREAM TCP
SOCK_DGRAM  UDP
SOCK_RAW    original sock

#include <sys/socket.h>
int socket(int family,int type,int protocol) //return sockfd
int connect(int sockfd, const struct sockaddr *servaddr,socklen_t addrlen);//suc=0,fail=-1
int bind(int sockfd, const struct sockaddr *myaddr,socklen_t addrlen);//suc=0,fail=-1
int listen(int sockfd,int backlog);//backlog is MAX incoming clients
int accept(int sockfd, const struct sockaddr *cliaddr,socklen_t addrlen);
int getsockname(int sockfd, struct sockaddr *localaddr,socklen_t addrlen);
int getpeername(int sockfd, struct sockaddr *peeraddr,socklen_t addrlen);

#include <sys/select.h>
#include <sys/time.h>
int select(int maxfdp1,fd_set *readsed,fd_set *writeset,fd_set *exceptset,const struct timeval *timeout);
#include <poll.h>
int poll(struct pollfd *fdarray,unsigned long nfds,int timeout);















