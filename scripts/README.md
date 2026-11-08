# Developer scripts

Run them from any directory; each script locates the repository root itself.
The CI entry points (`build-and-test-all*.sh`) stay in the repository root.

## `compose/` — for the `docker-compose.yml` stack

Start the stack first: `docker compose up -d --build --wait`.

| Script | Purpose |
|---|---|
| `db-cli.sh customer\|order [mysql args]` | MySQL shell on `customer-service-db` / `order-service-db` (schema `eventuate`) |
| `kafka.sh <tool> [args]` | Runs `/opt/kafka/bin/kafka-<tool>.sh` in the Kafka container, e.g. `kafka.sh topics --list` |
| `test-curl-commands.sh` | Runs the curl commands from the home page against `localhost:8083` (override with `API_GATEWAY`) |

## `testcontainers/` — for the stack started by Testcontainers

Start it with `./gradlew :end-to-end-tests:runApplicationMySQL` (or `...Postgres`).
These scripts attach to the Docker network `CustomersAndOrdersEndToEndTest`.

| Script | Purpose |
|---|---|
| `mysql-customer-service-cli.sh`, `mysql-order-service-cli.sh` | MySQL shell on a service database |
| `postgres-customer-service-cli.sh`, `postgres-order-service-cli.sh` | psql shell on a service database |
| `kafka-topics.sh`, `kafka-consumer-groups.sh` | Kafka CLI against `kafka:9093` |
| `test-curl-commands.sh` | Runs the curl commands from the home page against the API Gateway container |
