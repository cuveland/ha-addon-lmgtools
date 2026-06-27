# LMG95 Power Logger

Log measurements from a ZES Zimmer LMG95 precision power analyzer into Home
Assistant. The add-on connects to the LMG95 over an RS232-Ethernet converter and
can publish the readings via MQTT (with auto-discovery) and/or write them to an
InfluxDB database.

## Installation

1. Add this repository to the Home Assistant add-on store:
   `https://github.com/cuveland/ha-addon-lmgtools`
2. Install the **LMG95 Power Logger** add-on.
3. Configure it (see below) and start it.

## Device setup

The LMG95 is accessed over a serial-to-Ethernet converter (e.g. a Digi Connect
SP). Configure the converter for raw TCP access (typically port 2101) and the
LMG95 serial port for 115200 8N1 with RTS/CTS flow control. See the
[upstream lmgtools README][upstream] for detailed wiring and device-menu steps.

[upstream]: https://github.com/cuveland/lmgtools

## Configuration

### Connection

- **Device host** – Hostname or IP address of the RS232-Ethernet converter.
- **Device port** – TCP port of the converter (raw TCP, usually `2101`).
- **Measurement interval** – Seconds between measurements. The LMG95 rounds this
  to a whole number of signal periods.
- **60 Hz low-pass filter** – Enable the built-in low-pass filter to suppress
  high-frequency noise.
- **Log file** – Optional path inside the container for a raw measurement log.
  Leave empty to disable.

### MQTT (recommended)

Enable **Enable MQTT** to publish readings and have Home Assistant create the
sensors automatically via MQTT discovery.

- **MQTT broker host** – Use `core-mosquitto` for the official Mosquitto add-on.
- **MQTT broker port** – Usually `1883`.
- **MQTT base topic** – Values are published to `<topic>/state`.

The following sensors are exposed: active/reactive/apparent power, power factor,
RMS and DC voltage/current, frequency, crest and form factors, and cycle
metadata.

### InfluxDB (optional)

Enable **Enable InfluxDB** to additionally write measurements to an InfluxDB 1.x
database. The database is created automatically if it does not exist.

## Support

Issues and questions: <https://github.com/cuveland/ha-addon-lmgtools/issues>
