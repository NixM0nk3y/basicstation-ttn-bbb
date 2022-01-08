#!/usr/bin/env bash 

# Load common variables
source ./start_common.sh

# Change to project folder
cd examples/live-s2.sm.tc

# Setup TC files from environment
echo "$TC_URI" > tc.uri
echo "$TC_TRUST" > tc.trust
if [ ! -z ${TC_KEY} ]; then
	echo "Authorization: Bearer $TC_KEY" | perl -p -e 's/\r\n|\n|\r/\r\n/g'  > tc.key
fi

# Reset gateway
echo "Resetting gateway concentrator on GPIO pin 48."
/opt/ttn-gateway/reset

RADIODEV=$LORAGW_SPI ../../build-corecell-std/bin/station
