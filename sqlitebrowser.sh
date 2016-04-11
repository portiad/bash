#!/bin/bash
open -a XQuartz
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
docker run -it --rm \
  --net host \
  -v "$PWD":/root \
  -e DISPLAY=$(vboxmanage list hostonlyifs | grep IPAddress | sed 's/[^0-9.]*//g'):0 \
  --name sqlitebrowser \
  portiad/sqlitebrowser