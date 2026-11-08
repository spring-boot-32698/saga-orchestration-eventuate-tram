#! /bin/bash -e

# Runs kafka-consumer-groups.sh against the Kafka container started by Testcontainers
# (./gradlew :end-to-end-tests:runApplicationMySQL or the end-to-end tests).
# Example: scripts/testcontainers/kafka-consumer-groups.sh --describe --group customerCommandDispatcher

docker run --rm --network=CustomersAndOrdersEndToEndTest apache/kafka:3.8.0 \
  /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server kafka:9093 "$@"
