# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set environment variables
ENV KAFKA_VERSION=3.9.0 \
    SCALA_VERSION=2.13 \
    KAFKA_HOME=/opt/kafka \
    PATH=${PATH}:/opt/kafka/bin

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget net-tools dnsutils

# Download and extract Kafka
RUN wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -P /tmp && \
    tar -xvf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
    mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} && \
    rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Set the working directory
WORKDIR /opt/kafka

# Clean up
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Copy Kafka configuration files
COPY server.properties ${KAFKA_HOME}/config/

# Expose Kafka ports
EXPOSE 9092 2181

# Start Kafka
CMD ["sh", "-c", "bin/zookeeper-server-start.sh config/zookeeper.properties & bin/kafka-server-start.sh config/server.properties"]
