#!/bin/sh

set -e
set +u

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Use defaults if not set
if [ -z "${DEVICE_TELNET_PORT}" ]; then
   DEVICE_TELNET_PORT="20000"
fi

if [ -z "${TIMING_INSTANCE}" ]; then
   TIMING_INSTANCE="EVE1"
fi

set -u

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n TIMING_${TIMING_INSTANCE} -i ^C^D ${DEVICE_TELNET_PORT} ./runGenericModule.sh "$@"
