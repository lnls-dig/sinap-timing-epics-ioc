#Start from image
ARG DEBIAN_VERSION
FROM ${DEBIAN_VERSION}

#Define Environment Variables
ARG BASE_VERSION
ARG IOC_REPO
ENV BOOT_DIR ioctiming

#Install first dependencies
RUN apt update && apt install -y \
    build-essential \
    procserv \
    wget \
    python3 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

#Define Work directory as ioc repo
WORKDIR /opt/epics/${IOC_REPO}

#Install epics base and modules
COPY ./docker/epics_setup.sh ./
RUN ./epics_setup.sh ${BASE_VERSION} && \
    rm ./epics_setup.sh

#Copy ioc files and compile
COPY ./Makefile ./
COPY ./configure ./configure
COPY ./timingApp ./timingApp
COPY ./iocBoot ./iocBoot
COPY ./install ./install
RUN make install clean

#Remove unused packages
RUN apt update && \
    apt remove -y \
    build-essential \ 
    wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Set work directory to ioc boot and set ProcServ as entrypoint
WORKDIR /opt/epics/startup/ioc/${IOC_REPO}/iocBoot/${BOOT_DIR}
ENTRYPOINT ["./runProcServ.sh"]