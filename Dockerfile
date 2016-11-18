FROM java:8-jre

ENV CONFLUENT_USER confluent
ENV CONFLUENT_GROUP confluent

RUN ["groupadd", "-r", "confluent"]
RUN ["useradd", "-r", "-g", "confluent", "confluent"]

RUN wget -qO - http://packages.confluent.io/deb/3.0/archive.key | apt-key add -
RUN apt-get update && \
	apt-get install -y software-properties-common && \
	add-apt-repository "deb [arch=amd64] http://packages.confluent.io/deb/3.0 stable main" && \
	apt-get update && \
	apt-get install -y confluent-platform-2.11 && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc/kafka/*.properties /etc/kafka/
