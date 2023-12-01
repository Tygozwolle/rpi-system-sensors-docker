FROM python:3.9-alpine as build

WORKDIR /app
RUN wget -P /tmp/ "https://github.com/Tygozwolle/system_sensors/archive/refs/heads/master.tar.gz" \
  && tar -xvzf /tmp/master.tar.gz -C /app --strip-components 1 \
  && apk --update-cache add --virtual build-dependencies build-base linux-headers go
RUN pip install -r /app/requirements.txt
&& apt-get update
RUN GOBIN=/app go install github.com/a8m/envsubst/cmd/envsubst@v1.2.0

FROM python:3.9-alpine
RUN apk add bash wireless-tools

WORKDIR /app

COPY --from=build /app /app
COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY ./ ./
RUN chmod a+x ./system_sensors.sh
RUN chmod a+x ./envsubst
CMD ./system_sensors.sh

