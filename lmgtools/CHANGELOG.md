# Changelog

## 1.1.0

- Group InfluxDB and MQTT options into nested config sections.
- Require a device host before the add-on can start.
- Default the measurement interval to 1 second.
- Default the InfluxDB host to the Community Add-ons hostname
  (`a0d7b954-influxdb`).
- Add an add-on icon and logo.
- Pin the installed lmgtools version (v0.1.0) for reproducible builds.

## 1.0.0

- Initial release.
- Logs ZES Zimmer LMG95 measurements via an RS232-Ethernet converter.
- Optional InfluxDB 1.x output.
- Optional MQTT output with Home Assistant MQTT discovery.
