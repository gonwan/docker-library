#!/bin/sh
apk add openrc haproxy            \
  && mkdir -p /run/openrc         \
  && touch /run/openrc/softlevel  \
  && rc-status                    \
  && rc-service haproxy start
consul-template -consul-addr "172.16.111.110:8500" -template "/consul-template/data/haproxy.cfg.ctmpl:/etc/haproxy/haproxy.cfg:rc-service haproxy reload"
