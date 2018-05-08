#!/usr/bin/env bash

set -u

if [ -z "$TIMING_INSTANCE" ]; then
    echo "TIMING_INSTANCE environment variable is not set." >&2
    exit 1
fi

export TIMING_CURRENT_PV_AREA_PREFIX=TIMING_${TIMING_INSTANCE}_PV_AREA_PREFIX
export TIMING_CURRENT_PV_DEVICE_PREFIX=TIMING_${TIMING_INSTANCE}_PV_DEVICE_PREFIX
export TIMING_CURRENT_DEVICE_IP=TIMING_${TIMING_INSTANCE}_DEVICE_IP
export TIMING_CURRENT_DEVICE_PORT=TIMING_${TIMING_INSTANCE}_DEVICE_PORT
export TIMING_CURRENT_DEVICE_TELNET_PORT_SUFFIX=TIMING_${TIMING_INSTANCE}_TELNET_PORT_SUFFIX
# Only works with bash
export TIMING_PV_AREA_PREFIX=${!TIMING_CURRENT_PV_AREA_PREFIX}
export TIMING_PV_DEVICE_PREFIX=${!TIMING_CURRENT_PV_DEVICE_PREFIX}
export TIMING_DEVICE_IP=${!TIMING_CURRENT_DEVICE_IP}
export TIMING_DEVICE_PORT=${!TIMING_CURRENT_DEVICE_PORT}
export TIMING_DEVICE_TELNET_PORT=${PROCSERV_TIMING_PORT_PREFIX}${!TIMING_CURRENT_DEVICE_TELNET_PORT_SUFFIX}

if [ -z "${TIMING_CURRENT_DEVICE_TELNET_PORT_SUFFIX}" ]; then
    echo "TELNET port is not set." >&2
    exit 1
fi

TIMING_TYPE=$(echo ${TIMING_INSTANCE} | grep -Eo "[^0-9]+");

if [ -z "$TIMING_TYPE" ]; then
    echo "Device instance is invalid. Valid device options are: EVG, EVE, EVR and FOUT." >&2
    echo "The instance format is: <device type><device index>. Example: EVG1" >&2
    exit 5
fi

./runProcServ.sh \
    -t "${TIMING_DEVICE_TELNET_PORT}" \
    -P "${TIMING_PV_AREA_PREFIX}" \
    -R "${TIMING_PV_DEVICE_PREFIX}" \
    -i "${TIMING_DEVICE_IP}" \
    -p "${TIMING_DEVICE_PORT}" \
    -d "${TIMING_INSTANCE}"
