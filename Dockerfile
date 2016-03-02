FROM alpine:3.3
MAINTAINER Huy Doan <me@huy.im>

RUN apk add --update openjdk8 && rm -rf /var/cache/apk/*

RUN mkdir /opt
RUN wget -qO- "https://github.com/skavanagh/KeyBox/releases/download/v2.85.01/keybox-jetty-v2.85_01.tar.gz" | tar -xzC /opt

RUN rm -rf /opt/KeyBox-jetty/jetty/keybox/WEB-INF/classes/keydb
RUN rm -f /opt/KeyBox-jetty/jetty/keybox/WEB-INF/classes/KeyBoxConfig.properties
RUN rm -f /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.policy

VOLUME /opt/keydb

RUN ln -s /opt/keydb /opt/KeyBox-jetty/jetty/keybox/WEB-INF/classes/keydb
RUN ln -s /opt/keydb/KeyBoxConfig.properties /opt/KeyBox-jetty/jetty/keybox/WEB-INF/classes/KeyBoxConfig.properties

ADD startKeyBox.sh /opt/
RUN chmod +x /opt/startKeyBox.sh

WORKDIR /opt/KeyBox-jetty/jetty

EXPOSE 8443/tcp
ENTRYPOINT ["/opt/startKeyBox.sh"]
