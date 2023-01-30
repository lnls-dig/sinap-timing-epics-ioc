#!/bin/bash

if [ $# -eq 0 ]
then
    export BASE="3.15.6"
else
    export BASE=$1
fi

# Versions to be installed
export ASYN="4-33"
export SEQ="2-2-6"
export STREAM="2.8.8"
export CALC="3-7-1"
export AUTOSAVE="5-9"

#Run apt update
apt update

# EPICS Base
apt install -y libreadline-dev
cd /opt
mkdir epics-R${BASE}
cd epics-R${BASE}
wget https://epics-controls.org/download/base/base-${BASE}.tar.gz
tar -xvzf base-${BASE}.tar.gz
rm base-${BASE}.tar.gz
mv base-${BASE} base
cd base
make install clean
cd /opt/epics-R${BASE}
mkdir modules

# asynDriver
cd /opt/epics-R${BASE}/modules
wget https://github.com/epics-modules/asyn/archive/refs/tags/R${ASYN}.tar.gz
tar -xvzf R${ASYN}.tar.gz
rm R${ASYN}.tar.gz
cd asyn-R${ASYN}
sed -i -e "s|^.*EPICS_BASE=.*$|EPICS_BASE=/opt/epics-R${BASE}/base|" \
       -e "s|^.*SNCSEQ=.*$|#SNCSEQ=|" \
       -e "s|^.*CALC=.*$|#CALC=|" \
       -e "s|^.*IPAC=.*$|#IPAC=|" \
       -e "s|^.*SUPPORT=.*$|#SUPPORT=|" \
       configure/RELEASE
make install clean

# Sequencer
apt install -y re2c
cd /opt/epics-R${BASE}/modules
wget https://github.com/icshwi/sequencer-2-2/archive/refs/tags/R${SEQ}.tar.gz
tar -xvzf R${SEQ}.tar.gz
rm R${SEQ}.tar.gz
cd /opt/epics-R${BASE}/modules/sequencer-2-2-R${SEQ}
sed -i -e "s|^.*EPICS_BASE=.*$|EPICS_BASE=/opt/epics-R${BASE}/base|" configure/RELEASE
make install clean

#Calc
cd /opt/epics-R${BASE}/modules
wget  https://github.com/epics-modules/calc/archive/R${CALC}.tar.gz
tar -xvzf R${CALC}.tar.gz
rm R${CALC}.tar.gz
cd calc-R${CALC}
sed -i -e "s|^.*SUPPORT=.*$|#SUPPORT=|" \
       -e "8s/^/#/" \
       -e "s|^.*SSCAN=.*$|#SSCAN=|" \
       -e "s|^.*EPICS_BASE=.*$|EPICS_BASE=/opt/epics-R${BASE}/base|" \
       configure/RELEASE
make install clean

#Stream
apt install -y libpcre3 libpcre3-dev
cd /opt/epics-R${BASE}/modules
wget  https://github.com/paulscherrerinstitute/StreamDevice/archive/${STREAM}.tar.gz
tar -xvzf ${STREAM}.tar.gz
rm ${STREAM}.tar.gz
cd StreamDevice-${STREAM}
sed -i -e "s|^.*EPICS_BASE=.*$|EPICS_BASE=/opt/epics-R${BASE}/base|" \
       -e "s|^.*ASYN=.*$|ASYN=/opt/epics-R${BASE}/modules/asyn-R${ASYN}|" \
       -e "s|^.*CALC=.*$|CALC=/opt/epics-R${BASE}/modules/calc-R${CALC}|" \
       -e "23cPCRE_INCLUDE=/usr/include/pcre" \
       -e "24cPCRE_LIB=/usr/lib64" \
       configure/RELEASE
make install clean

# Autosave
cd /opt/epics-R${BASE}/modules
wget https://github.com/epics-modules/autosave/archive/R${AUTOSAVE}.tar.gz
tar -xvzf R${AUTOSAVE}.tar.gz
rm R${AUTOSAVE}.tar.gz
cd autosave-R${AUTOSAVE}
sed -i -e "s|^.*EPICS_BASE=.*$|EPICS_BASE=/opt/epics-R${BASE}/base|" \
       -e "s|^.*SUPPORT=.*$|#SUPPORT=|" \
       configure/RELEASE
make install clean

#Clean apt to reduce layer size
apt clean
rm -rf /var/lib/apt/lists/*