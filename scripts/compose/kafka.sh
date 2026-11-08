#! /bin/bash -e

# Runs a Kafka CLI tool inside the kafka container of the docker-compose stack.
#
#   scripts/compose/kafka.sh topics --list
#   scripts/compose/kafka.sh consumer-groups --describe --group customerCommandDispatcher
#   scripts/compose/kafka.sh console-consumer --topic customerService --from-beginning --max-messages 1

TOOL=${1:?usage: $0 topics|consumer-groups|console-consumer|... [args...]}
shift

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

TTY_FLAG=""
[ -t 0 ] || TTY_FLAG="-T"

exec docker compose -f "$ROOT/docker-compose.yml" exec $TTY_FLAG kafka \
  "/opt/kafka/bin/kafka-$TOOL.sh" --bootstrap-server localhost:9092 "$@"
