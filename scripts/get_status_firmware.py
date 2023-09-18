#!/usr/bin/env python3

from lib.sinap import EVO
import argparse

parser = argparse.ArgumentParser(description="Read SINAP device status and hostname")
parser.add_argument("hostname", help="pass hostname (or ip) as first argument")
parser.add_argument("-p","--port", type=int, default=50132, help="Pass server port integer")
parser.add_argument("-P","--protocol",choices=['tcp', 'udp', 'udp-force-local'], default='tcp', help="pass protocol")
parser.add_argument("--header", default=True, action="store_true", help="select if header should be software appended")

args = parser.parse_args()

#Standard constructor use TCP socket and header True, with socket port 50132
evr = EVO(args.hostname,port = args.port,protocol = args.protocol,header = args.header)
evr.ReadStatus()
evr.ReadVersion()
evr.close()