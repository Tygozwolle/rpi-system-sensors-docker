FROM python:3.12.4-alpine3.19 as build

WORKDIR /app
USER root
RUN wget -P /tmp/ "https://github.com/Tygozwolle/system_sensors/archive/refs/tags/2.4.0.tar.gz" \
  && tar -xvzf /tmp/2.4.0.tar.gz -C /app --strip-components 1 \
  && apk --update-cache add --virtual build-dependencies build-base linux-headers go
RUN pip install -r /app/requirements.txt 
RUN GOBIN=/app go install github.com/a8m/envsubst/cmd/envsubst@v1.4.2

FROM python:3.12.4-alpine3.19
RUN apk add bash wireless-tools
RUN apk add bash apt

WORKDIR /app

COPY --from=build /app /app
COPY --from=build /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY ./ ./
RUN chmod a+x ./system_sensors.sh
RUN chmod a+x ./envsubst
CMD ./system_sensors.sh

