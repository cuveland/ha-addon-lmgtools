# Changelog

## 1.4.1

- Show progress messages in the log in real time (unbuffered stdout), so
  startup status is visible instead of being held back by block buffering.

## 1.4.0

- Add automatic measurement ranging, enabled by default, so small currents and
  powers are captured (lmgtools v0.5.0). Disable it to set a fixed range.
- Shut down cleanly on stop (SIGTERM): the device is released back to local
  mode instead of being left in remote mode.
- Stop spamming the log with the measurement counter when running headless.

## 1.3.1

- Make device startup robust against leftover continuous-measurement data
  from a previous session, which could desynchronize the protocol and crash
  with an IndexError (lmgtools v0.4.0).

## 1.3.0

- Use Home Assistant MQTT service discovery: broker host, port, and
  credentials are configured automatically (lmgtools v0.3.0).
- Log the MQTT connection result so authentication problems are visible.
- Remove the manual MQTT host/port options (now provided by the service).

## 1.2.0

- Add InfluxDB username/password authentication (lmgtools v0.2.0).
- Tolerate a write-only InfluxDB user that cannot create the database.

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
