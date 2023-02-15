# SINAP Timing Epics IOC

> LNLS - Brazilian Synchrotron Light Laboratory  
> CNPEM - Brazilian Center for Research in Energy and Materials  

## Running the IOC

See the repository registry to find the image. The image uses [ProcServ](https://linux.die.net/man/1/procserv) to run the IOC with parameters:

- `i`: Configure IP address to connect to device
- `t`: Configure procServ telnet port
- `P`: Configure value of \$(P) macro
- `R`: Configure value of \$(R) macro
- `p`: Configure IP port number to connect to device
- `d`: Configure Sinap Timing device type [EVG<number>|EVR<number>|EVE<number>|FOUT<number>]
- `l`: Configure High-level events link to load at EVG

E.g.: 

`docker run -d --name EVE01 -it -v /ioc-autosave/EVE01:/opt/epics/startup/ioc/sinap-timing-epics-ioc/iocBoot/ioctiming/autosave --net host ghcr.io/lnls-dig/sinap-timing-epics-ioc -i 192.168.0.1 -t 1000 -p 1001 -d EVE01 -P TEST: -R EVE01:`

### How to build docker image

Run `docker compose` from docker directory saving COMMIT_ID as environemnt variable:

`COMMIT_ID=$(git rev-parse --short HEAD) docker compose build --build-arg .env`