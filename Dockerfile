FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/var/cache/apt-cacher-ng"]

RUN apt-get update && apt-get install -qqy apt-cacher-ng && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 3142
CMD chmod 777 /var/cache/apt-cacher-ng && \
  /etc/init.d/apt-cacher-ng start && \
  tail -f /var/log/apt-cacher-ng/*
