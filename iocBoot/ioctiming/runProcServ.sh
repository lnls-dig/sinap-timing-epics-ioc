#!/bin/sh

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n TIMING -i ^C^D 20000 ./runGenericModule.sh "$@"
