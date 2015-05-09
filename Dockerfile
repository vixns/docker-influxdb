FROM vixns/base
MAINTAINER Stéphane Cottin <stephane.cottin@vixns.com>

ENV INFLUXDB_VERSION 0.8.8

RUN curl -s -k -o /tmp/influxdb.deb https://s3.amazonaws.com/influxdb/influxdb_${INFLUXDB_VERSION}_amd64.deb

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && apt-get -y dist-upgrade && \
  dpkg -i /tmp/influxdb.deb && \
  rm /tmp/influxdb.deb && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 8083 8086 8099
VOLUME ["/opt/influxdb/shared/data"]
WORKDIR /opt/influxdb
CMD ["/opt/influxdb/current/influxdb", "-config=/opt/influxdb/current/config.toml","-stdout=true"]
