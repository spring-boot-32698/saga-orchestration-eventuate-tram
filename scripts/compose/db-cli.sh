#! /bin/bash -e

# Opens a MySQL shell on a database of the docker-compose stack.
#
#   scripts/compose/db-cli.sh customer
#   scripts/compose/db-cli.sh order -e "SELECT id, state, rejection_reason FROM orders"
#   echo "SELECT * FROM saga_instance" | scripts/compose/db-cli.sh order

SERVICE=${1:?usage: $0 customer|order [mysql args...]}
shift

case "$SERVICE" in
  customer|order) ;;
  *) echo "unknown database: $SERVICE (expected customer or order)" >&2; exit 1 ;;
esac

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

TTY_FLAG=""
[ -t 0 ] || TTY_FLAG="-T"

exec docker compose -f "$ROOT/docker-compose.yml" exec $TTY_FLAG "$SERVICE-service-db" \
  mysql -uroot -prootpassword eventuate "$@"
