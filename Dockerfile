# based on jaysonsantos/docker-minecraft-ftb-skyfactory3

FROM java:8

MAINTAINER example@example.com

# manual upgrades only chaps
# when you upgrade, you are responsible for removing the duplicate mods from your ./mods folder on your volume.
ENV VERSION=3.0.7

RUN apt-get update && apt-get install -y wget unzip
RUN adduser --disabled-password --home=/data --uid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/ftb && cd /tmp/ftb && \
  wget -c https://media.forgecdn.net/files/2560/178/SevTech_Ages_Server_${VERSION}.zip -O sevtech.zip && \
	unzip sevtech.zip && \
	chown -R minecraft /tmp/ftb && \
	bash /tmp/ftb/Install.sh

USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD Sevtech ${VERSION} CAVEMAN on docker
ENV JVM_OPTS -Xms4096m -Xmx4096m
ENV FLIGHT true
