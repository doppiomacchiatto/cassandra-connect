FROM confluentinc/cp-kafka-connect-base:7.0.1

RUN curl -O -L "https://downloads.datastax.com/kafka/kafka-connect-cassandra-sink.tar.gz" \
&& mkdir datastax-connector \
&& tar xzf kafka-connect-cassandra-sink.tar.gz -C datastax-connector --strip-components=1 \
&& mv datastax-connector/kafka-connect* datastax-connector/kafka-connect-cassandra.jar

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/datastax-connector/kafka-connect-cassandra.jar"

WORKDIR /usr/app

COPY connect/ /usr/app
USER root
RUN chmod +x *.sh
USER appuser
CMD [ "/bin/bash", "-c", "echo \"Launching Kafka Connect worker\" & \
/etc/confluent/docker/run & /usr/app/start-and-wait.sh"]