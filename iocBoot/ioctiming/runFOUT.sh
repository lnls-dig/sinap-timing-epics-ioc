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

cd "$IOC_BOOT_DIR"

IPADDR="$IPADDR" IPPORT="$IPPORT" PORT="$PORT" P="$P" R="$R" "$IOC_BIN" stFOUT.cmd
