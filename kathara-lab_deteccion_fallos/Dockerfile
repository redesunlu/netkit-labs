FROM kathara/quagga
ARG DEBIAN_FRONTEND="noninteractive"
RUN apt update
RUN apt upgrade -y
RUN apt install -y quagga

RUN apt install -y \
	exim4 \ 
	tshark \
	iptables \
	xinetd \
	dovecot-pop3d \
	squid3 \
	lynx \
	telnetd \
	apache2 \
	radvd \
	alpine \
	&& rm -rf /var/lib/apt/lists/*
 #RUN     echo root:malware | chpasswd && \
 #	echo "# default: on \n \
 #	    # description: The telnet server serves telnet sessions; it uses unencrypted username/password pairs for authentication. \n \
 #	    service telnet \n \
 #	    { \n \
 #	    disable = no \n \
 #	    flags           = REUSE \n \
 #	    socket_type     = stream \n \
 #	    wait            = no \n \
 #	    user            = root \n \
 #	    server          = /usr/sbin/in.telnetd \n \
 #	    log_on_failure  += USERID \n \
 #	    }" | tee -a /etc/xinetd.d/telnet && \
 #	rm -f /etc/securetty

RUN apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ENTRYPOINT ["bash"]
#CMD ["-c","xinetd -dontfork -stayalive"]

