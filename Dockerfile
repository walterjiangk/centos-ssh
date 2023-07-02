FROM ubuntu:20.04
MAINTAINER malaohu <tua@live.cn>
RUN apt-get update && \
    apt-get install -y openssh-server python-pip libnet1 libnet1-dev libpcap0.8 libpcap0.8-dev git


RUN echo "root:password"|chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
    
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
EXPOSE 22
