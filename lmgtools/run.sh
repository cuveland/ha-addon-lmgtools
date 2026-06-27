#!/usr/bin/with-contenv bashio

HOST=$(bashio::config 'host')
PORT=$(bashio::config 'port')
INTERVAL=$(bashio::config 'interval')
LOGFILE=$(bashio::config 'logfile')

ARGS="${HOST} -p ${PORT} -i ${INTERVAL}"

if bashio::config.true 'lowpass'; then
    ARGS="${ARGS} --lowpass"
fi

if [ -n "${LOGFILE}" ]; then
    ARGS="${ARGS} -L ${LOGFILE}"
fi

if bashio::config.true 'influxdb_enabled'; then
    INFLUXDB_HOST=$(bashio::config 'influxdb_host')
    INFLUXDB_PORT=$(bashio::config 'influxdb_port')
    INFLUXDB_DATABASE=$(bashio::config 'influxdb_database')
    ARGS="${ARGS} --influxdb --influxdb-host ${INFLUXDB_HOST} --influxdb-port ${INFLUXDB_PORT} --influxdb-database ${INFLUXDB_DATABASE}"
fi

if bashio::config.true 'mqtt_enabled'; then
    MQTT_HOST=$(bashio::config 'mqtt_host')
    MQTT_PORT=$(bashio::config 'mqtt_port')
    MQTT_TOPIC=$(bashio::config 'mqtt_topic')
    ARGS="${ARGS} --mqtt --mqtt-host ${MQTT_HOST} --mqtt-port ${MQTT_PORT} --mqtt-topic ${MQTT_TOPIC}"
fi

bashio::log.info "Starting LMG95 power logger for host ${HOST}"
exec powerlog95 ${ARGS}
