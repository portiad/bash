#!/bin/bash
open -a XQuartz
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
docker run -d --rm \
  --net host \
  -v ~/Pictures:/root/Pictures \
  -e DISPLAY=$(vboxmanage list hostonlyifs | grep IPAddress | sed 's/[^0-9.]*//g'):0 \
  --name gimp \
  jess/gimp