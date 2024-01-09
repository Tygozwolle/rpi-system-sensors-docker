# Dockerized RPI System Sensors

Alpine-based docker image of the RPI System sensors project: <https://github.com/tygozwolle/system_sensors>

## Environment Variables
```
MQTT_HOST (default '127.0.0.1')
MQTT_PORT (default '1883')
MQTT_USER
MQTT_PASSWORD
DEVICE_NAME (default 'test')
CLIENT_ID (default 'test')
TIMEZONE (default 'Europe/Brussels')
UPDATE_INTERVAL (default '60')
SENSORS_TEMPERATURE (default 'true')
SENSORS_CLOCK_SPEED (default 'true')
SENSORS_DISK_USE (default 'true')
SENSORS_MEMORY_USE (default 'true')
SENSORS_CPU_USAGE (default 'true')
SENSORS_LOAD1 (default 'true')
SENSORS_LOAD5 (default 'true')
SENSORS_LOAD15 (default 'true')
SENSORS_NET_TX (default 'true')
SENSORS_NET_RX (default 'true')
SENSORS_SWAP_USAGE (default 'true')
SENSORS_POWER_STATUS (default 'true')
SENSORS_LAST_BOOT (default 'true')
SENSORS_HOSTNAME (default 'true')
SENSORS_HOST_IP (default 'true')
SENSORS_HOST_OS (default 'true')
SENSORS_HOST_ARCH (default 'true')
SENSORS_LAST_MESSAGE (default 'true')
SENSORS_UPDATES (default 'true')
SENSORS_WIFI_STRENGTH (default 'true')
SENSORS_WIFI_SSID (default 'true')
```

## Examples

### docker-compose.yml

```yaml
version: "3"

services:

  sensors:
    image: tygozwolle/rpi-system-sensors-docker:latest
    container_name: system-sensors
    hostname: rpi
    environment:
      - MQTT_HOST=192.168.100.100
    restart: unless-stopped
    devices:
      - /dev/vchiq
    volumes:
      - /etc/os-release:/app/host/os-release:ro
      - /etc/hostname:/app/host/hostname:ro
```

### docker
```bash
docker run -d \
  -v /etc/os-release:/etc/os-release:ro \
  -h $(hostname -f)
  --device /dev/vchiq \
  -e MQTT_HOST=192.168.100.100 \
  tygozwolle/rpi-system-sensors-docker:latest
```

