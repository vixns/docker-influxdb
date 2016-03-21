FROM vixns/base
MAINTAINER Stéphane Cottin <stephane.cottin@vixns.com>

ENV INFLUXDB_VERSION 0.10.3-1

RUN \
 export DEBIAN_FRONTEND=noninteractive && \
 apt-get update && apt-get -y install apt-transport-https && \
 curl -sL https://repos.influxdata.com/influxdb.key | apt-key add - && \
 echo "deb https://repos.influxdata.com/debian jessie stable" | tee /etc/apt/sources.list.d/influxdb.list && \
 apt-get update && apt-get -y install influxdb=$INFLUXDB_VERSION && \
 rm -rf /var/lib/apt/lists/*

EXPOSE 8083 8086 8088 8091
VOLUME ["/var/lib/influxdb"]
CMD ["/usr/bin/influxd", "-config" , "/etc/influxdb/influxdb.conf"]
