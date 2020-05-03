#!/bin/bash

action="$1"

case $action in
  add)
    rc-update -q add vmware-server default
    rc-service vmware-server start
    ;;
  remove)
    rc-update -q del vmware-server default
    rc-service vmware-server stop
    ;;
  status)
    rc-service -q vmware-server status
    ;;
  *)
    exit 1
    ;;
esac
