#!/bin/bash
echo SYSTEM=\"MagOS Linux\" > etc/sysconfig/oem
echo PRODUCT=2012 >> etc/sysconfig/oem
cat >etc/os-release <<EOF
NAME="MagOS Linux 2014"
VERSION="2014"
ID=rosa
VERSION_ID=2014.1
PRETTY_NAME="MagOS Linux"
ANSI_COLOR="1;34"
HOME_URL="http://www.magos-linux.ru/"
BUG_REPORT_URL="http://www.magos-linux.ru/"
EOF
