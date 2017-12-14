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

if [ -z "$DEVICE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 5
fi

TIMING_TYPE=$(echo ${DEVICE} | grep -Eo "[^0-9]+");
TIMING_NUMBER=$(echo ${DEVICE} | grep -Eo "[0-9]+");

if [ -z "$TIMING_TYPE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 5
fi

if [ -z "$TIMING_NUMBER" ]; then
    echo "Device number is not set. Please use -d option" >&2
    exit 6
fi

case ${TIMING_TYPE} in
    EVG)
        ST_CMD_FILE=stEVG.cmd
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
