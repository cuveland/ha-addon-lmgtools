#!/usr/bin/with-contenv bashio

HOST=$(bashio::config 'host')
PORT=$(bashio::config 'port')
INTERVAL=$(bashio::config 'interval')

ARGS="${HOST} -p ${PORT} -i ${INTERVAL}"

if bashio::config.true 'lowpass'; then
    ARGS="${ARGS} --lowpass"
fi

if bashio::config.has_value 'logfile'; then
    LOGFILE=$(bashio::config 'logfile')
    ARGS="${ARGS} -L ${LOGFILE}"
fi

if bashio::config.true 'influxdb.enabled'; then
    INFLUXDB_HOST=$(bashio::config 'influxdb.host')
    INFLUXDB_PORT=$(bashio::config 'influxdb.port')
    INFLUXDB_DATABASE=$(bashio::config 'influxdb.database')
    ARGS="${ARGS} --influxdb --influxdb-host ${INFLUXDB_HOST} --influxdb-port ${INFLUXDB_PORT} --influxdb-database ${INFLUXDB_DATABASE}"
    if bashio::config.has_value 'influxdb.username'; then
        INFLUXDB_USERNAME=$(bashio::config 'influxdb.username')
        INFLUXDB_PASSWORD=$(bashio::config 'influxdb.password')
        ARGS="${ARGS} --influxdb-username ${INFLUXDB_USERNAME} --influxdb-password ${INFLUXDB_PASSWORD}"
    fi
fi

if bashio::config.true 'mqtt.enabled'; then
    MQTT_HOST=$(bashio::config 'mqtt.host')
    MQTT_PORT=$(bashio::config 'mqtt.port')
    MQTT_TOPIC=$(bashio::config 'mqtt.topic')
    ARGS="${ARGS} --mqtt --mqtt-host ${MQTT_HOST} --mqtt-port ${MQTT_PORT} --mqtt-topic ${MQTT_TOPIC}"
fi

bashio::log.info "Starting LMG95 power logger for host ${HOST}"
exec powerlog95 ${ARGS}
