
if [ ! -f "/app/config.yaml" ]; then
    /app/envsubst < /app/settings_docker.yaml > /app/config.yaml
fi

python /app/src/system_sensors.py /app/config.yaml

