#! /bin/bash -e

# Runs kafka-topics.sh against the Kafka container started by Testcontainers
# (./gradlew :end-to-end-tests:runApplicationMySQL or the end-to-end tests).
# Example: scripts/testcontainers/kafka-topics.sh --list

docker run --rm --network=CustomersAndOrdersEndToEndTest apache/kafka:3.8.0 \
  /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9093 "$@"
