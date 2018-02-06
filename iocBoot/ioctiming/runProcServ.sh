#!/bin/sh

# Use defaults is not set
if [ -z "${TIMING_DEVICE_TELNET_PORT}" ]; then
    TIMING_DEVICE_TELNET_PORT=20000
fi

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n timing${RSFSV_INSTANCE} -i ^C^D ${RSFSV_DEVICE_TELNET_PORT} ./runGenericModule.sh "$@"
