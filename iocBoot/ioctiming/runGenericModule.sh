#!/bin/sh

# Source environment
. ./checkEnv.sh

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Check last command return status
if [ $? -ne 0 ]; then
	echo "Could not parse command-line options" >&2
	exit 1
fi

if [ -z "$IPADDR" ]; then
    echo "IP address not set. Please use -i option or set \$IPADDR environment variable" >&2
    exit 3
fi

if [ -z "$IPPORT" ]; then
    echo "IP port number not set. Please use -p option or set \$IPPORT environment variable" >&2
    exit 4
fi

if [ -z "$DEVICE_TYPE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 5
fi

TIMING_TYPE=$(echo ${DEVICE_TYPE} | grep -Eo "[^0-9]+");

if [ -z "$TIMING_TYPE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 5
fi

case ${TIMING_TYPE} in
    EVG)
        ST_CMD_FILE=stEVG.cmd
        echo "EVG Device: running event_alias.py to generate high-level events alias"
        if [ -z "$HIGH_LEVEL_LINK" ]; then
            /usr/bin/python3 event_alias.py
        else
            /usr/bin/python3 event_alias.py ${HIGH_LEVEL_LINK}
        fi
        ;;

    EVR)
        ST_CMD_FILE=stEVR.cmd
        ;;

    EVE)
        ST_CMD_FILE=stEVE.cmd
        ;;

    FOUT)
        ST_CMD_FILE=stFOUT.cmd
        ;;

    *)
        echo "Invalid Timing module type: "${TIMING_TYPE} >&2
        exit 7
        ;;
esac

echo "Using st.cmd file: "${ST_CMD_FILE}

cd "$IOC_BOOT_DIR"

IPADDR="$IPADDR" IPPORT="$IPPORT" P="$P" R="$R" "$IOC_BIN" "$ST_CMD_FILE"
