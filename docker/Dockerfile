FROM debezium/connect:latest

ENV CONNECTOR_NAME=debezium
ENV ENV_PREFIX=DEBEZIUM_CONFIG_

COPY include /setup

CMD /setup/initialize.sh