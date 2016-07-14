FROM haproxy:1.6

RUN apt-get update; \
	apt-get install -y vim ruby-full;

RUN groupadd haproxy && useradd -g haproxy haproxy
RUN mkdir /var/lib/haproxy; \
	mkdir /root/templates

COPY files/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY files/haproxy /usr/local/sbin/haproxy 

ADD scripts/* /root/
ADD files/haproxy.cfg.erb /root/templates/haproxy.cfg.erb

ENV PICKLE_RELAY_LISTENERS "relay:2004"
ENV LINE_RELAY_LISTENERS "relay:2003"

ENTRYPOINT ["/root/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]