#!/bin/bash
SERVICESMASK="atd abrtd irqbalance smartd bumblebeed crond hddtemp lircd lircmd \
dhcpd6 ip6tables ebtables sshd tor rpcbind hostapd avahi-daemon avahi-dnsconfd ntpd openl2tp snmpd xl2tpd mdmonitor\
fedora-loadmodules fedora-storage-init-late fedora-storage-init  blk-availability shorewall rtkit-daemon \
canberra-system-bootup canberra-system-shutdown-reboot canberra-system-shutdown"
SERVICESFORCEMASK="ldconfig xinetd lvm2-activation-early lvm2-activation-net lvm2-activation smb nmb remount-rootfs \
NetworkManager-wait-online arp-ethers.service dbus-org.freedesktop.Avahi"
SERVICESSTOP="dhcpd wine"
for a in ${SERVICESMASK} ;do
    [ -f /lib/systemd/system/$a.service ] &&  ln -s '/dev/null' "/etc/systemd/system/$a.service"
done
for a in $SERVICESSTOP ;do
    [ -f /lib/systemd/system/$a.service ] &&  systemctl disable $a.service
done
for a in ${SERVICESFORCEMASK} ;do
    ln -sf '/dev/null' "/etc/systemd/system/$a.service"
done
PFP=/etc/systemd/coredump.conf
sed -i /Storage=/d $PFP
echo Storage=none >> $PFP
exit 0
