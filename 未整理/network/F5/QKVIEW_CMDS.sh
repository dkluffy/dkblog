  Commands
   tmsh
   apm
   list /apm aaa oscp all-properties
   list /apm log-setting all-properties
   show /apm epsec software-status
   auth
   list /auth partition all-properties
   cli
   show /cli history
   cm
   list /cm all-properties
   list /cm device
   list /cm device-group
   list /cm traffic-group all-properties
   show /cm device
   show /cm device-group
   show /cm failover-status
   show /cm sync-status
   show /cm traffic-group
   ltm
   list /ltm auth ocsp-responder all-properties
   list /ltm auth profile all-properties
   list /ltm auth ssl-ocsp all-properties
   list /ltm classification url-cat-policy all-properties
   list /ltm classification url-category all-properties
   list /ltm classification urldb-feed-list all-properties
   list /ltm classification urldb-file all-properties
   list /ltm data-group
   list /ltm dns cache all-properties
   list /ltm lsn-pool all-properties
   list /ltm monitor diameter all-properties
   list /ltm monitor dns all-properties
   list /ltm monitor external all-properties
   list /ltm monitor firepass all-properties
   list /ltm monitor ftp all-properties
   list /ltm monitor gateway-icmp all-properties
   list /ltm monitor http all-properties
   list /ltm monitor https all-properties
   list /ltm monitor icmp all-properties
   list /ltm monitor imap all-properties
   list /ltm monitor inband all-properties
   list /ltm monitor ldap all-properties
   list /ltm monitor module-score all-properties
   list /ltm monitor mssql all-properties
   list /ltm monitor mysql all-properties
   list /ltm monitor nntp all-properties
   list /ltm monitor none all-properties
   list /ltm monitor oracle all-properties
   list /ltm monitor pop3 all-properties
   list /ltm monitor postgresql all-properties
   list /ltm monitor radius all-properties
   list /ltm monitor radius-accounting all-properties
   list /ltm monitor real-server all-properties
   list /ltm monitor rpc all-properties
   list /ltm monitor sasp all-properties
   list /ltm monitor scripted all-properties
   list /ltm monitor sip all-properties
   list /ltm monitor smb all-properties
   list /ltm monitor smtp all-properties
   list /ltm monitor snmp-dca all-properties
   list /ltm monitor snmp-dca-base all-properties
   list /ltm monitor soap all-properties
   list /ltm monitor tcp all-properties
   list /ltm monitor tcp-echo all-properties
   list /ltm monitor tcp-half-open all-properties
   list /ltm monitor udp all-properties
   list /ltm monitor virtual-location all-properties
   list /ltm monitor wap all-properties
   list /ltm monitor wmi all-properties
   list /ltm nat all-properties
   list /ltm node all-properties
   list /ltm policy all-properties
   list /ltm pool all-properties
   list /ltm profile analytics all-properties
   list /ltm profile client-ssl all-properties
   list /ltm profile diameter all-properties
   list /ltm profile dns all-properties
   list /ltm profile fastl4 all-properties
   list /ltm profile http all-properties
   list /ltm profile http-compression all-properties
   list /ltm profile httpclass all-properties
   list /ltm profile radius all-properties
   list /ltm profile server-ssl all-properties
   list /ltm profile sip all-properties
   list /ltm profile tcp all-properties
   list /ltm profile udp all-properties
   list /ltm profile web-acceleration all-properties
   list /ltm profile xml all-properties
   list /ltm rule
   list /ltm snat all-properties
   list /ltm snatpool all-properties
   list /ltm virtual all-properties
   list /ltm virtual-address all-properties
   show /ltm auth profile
   show /ltm auth profile global
   show /ltm dns cache
   show /ltm lsn-pool
   show /ltm lsn-pool failure-cause
   show /ltm nat
   show /ltm node
   show /ltm policy
   show /ltm pool
   show /ltm pool members
   show /ltm profile client-ssl
   show /ltm profile client-ssl global
   show /ltm profile diameter
   show /ltm profile dns
   show /ltm profile fastl4
   show /ltm profile http
   show /ltm profile http global
   show /ltm profile http-compression
   show /ltm profile http-compression global
   show /ltm profile httpclass
   show /ltm profile one-connect
   show /ltm profile radius
   show /ltm profile ramcache all
   show /ltm profile server-ssl
   show /ltm profile server-ssl global
   show /ltm profile sip
   show /ltm profile tcp
   show /ltm profile tcp global
   show /ltm profile udp
   show /ltm profile udp global
   show /ltm profile web-acceleration
   show /ltm profile websocket
   show /ltm profile xml
   show /ltm rule all
   show /ltm snat
   show /ltm snatpool
   show /ltm virtual all-properties
   show /ltm virtual-address all-properties
   tmsh list sys outbound-smtp mailhub
   net
   list /net interface all-properties -hidden
   list /net ipsec ike-daemon all-properties
   list /net ipsec ike-peer all-properties
   list /net ipsec ipsec-policy all-properties
   list /net ipsec manual-security-association all-properties
   list /net ipsec traffic-selector all-properties
   list /net packet-filter all-properties
   list /net port-mirror all-properties
   list /net route all-properties
   list /net route-domain all-properties
   list /net self all-properties
   list /net stp-globals
   list /net trunk all-properties -hidden
   list /net tunnels all-properties
   list /net vlan all-properties -hidden
   list /net vlan-group all-properties
   show /net arp
   show /net fdb all-records
   show /net interface all-properties -hidden
   show /net ipsec ike-sa all-properties
   show /net ipsec ipsec-sa all-properties
   show /net ipsec traffic-selector
   show /net ipsec-stat
   show /net ndp all
   show /net packet-filter
   show /net route
   show /net rst-cause
   show /net self
   show /net stp
   show /net trunk all-properties -hidden
   show /net tunnels
   show /net vlan all-properties -hidden
   show /net vlan-group all-properties
   show running-config /net self
   security
   list /security dos device-config all-properties
   list /security dos profile all-properties
   show /security dos
   show /security dos device-config
   show /security firewall
   show /security ip-intelligence profile
   sys
   list /security log profile
   list /sys application service recursive all-properties
   list /sys cluster all-properties
   list /sys crypto key
   list /sys daemon-ha all-properties
   list /sys db all-properties
   list /sys db all-properties (non-default values)
   list /sys db systemauth.source all-properties
   list /sys disk all-properties
   list /sys feature-module all-properties
   list /sys folder recursive all-properties
   list /sys ha-group all-properties
   list /sys httpd ssl-ciphersuite
   list /sys httpd ssl-protocol
   list /sys management-ip all-properties
   list /sys management-route all-properties
   list /sys provision all-properties
   list /sys service all
   list /sys snmp
   list /sys snmp disk-monitors
   list /sys snmp process-monitors
   list /sys software
   list /sys software update-status
   list /sys syslog all-properties
   show /sys alert
   show /sys cluster all-properties
   show /sys cluster memory
   show /sys cpu
   show /sys crypto fips
   show /sys crypto fips key field-fmt all-properties
   show /sys crypto fips key field-fmt include-public-keys all-properties
   show /sys failover
   show /sys ha-group detail
   show /sys ha-status
   show /sys hardware
   show /sys host-info global
   show /sys ip-stat
   show /sys license detail
   show /sys mac-address
   show /sys mcp-state
   show /sys memory
   show /sys memory (text only)
   show /sys proc-info
   show /sys provision
   show /sys pva-traffic
   show /sys pva-traffic global
   show /sys raid
   show /sys service all
   show /sys software
   show /sys tmm-info
   show /sys tmm-info global
   show /sys tmm-traffic
   show /sys tmm-traffic global
   show /sys traffic
   show /sys traffic all-properties
   show /sys version detail
   show running-config /sys management-ip
   show running-config /sys management-route all-properties
   vcmp
   list /vcmp guest all-properties
   list /vcmp virtual-disk all-properties
   show /vcmp global
   show /vcmp guest all-properties
   show /vcmp health ha-status
   show /vcmp health module-provision
   show /vcmp health prompt
   show /vcmp health software
   show /vcmp virtual-disk
   UNIX
   Configuration
   crontab -l
   eud_info (version)
   fipsutil info
   grep -i TOTAL_TPS /config/bigip.license
   grub default -d
   grub default -l
   halcmd -mdisk
   halid
   hsb snapshot (version)
   hsb_tool -m edag
   lspci -vvv
   rpm -qa
   swapon -s
   sysctl
   Current Data
   /sbin/ausearch -m avc -ts today
   arp -an
   array
   cat /proc/bus/usb/devices
   cat /proc/interrupts
   cat /proc/mdstat
   cat /proc/meminfo
   cat /proc/partitions
   cat /proc/unic
   cat /var/tmp/merged.state
   date
   date +%s
   df -h
   df -i
   df -ik
   dmidecode -t1
   dmidecode -t1 -t8 -t17
   dmraid -r
   dmraid -s
   eud_log
   free
   hdparm -I /dev/sda
   history
   ipcs
   ipcs -t
   last -350
   lsmod
   lvscan
   mdadm --detail --scan
   mount
   nethsm-info.sh
   ntpdc -n -c peer 127.0.0.1
   ntpq -pn
   ps aux
   pstree
   sfdisk -l /dev/hda
   sfdisk -l /dev/hdc
   sfdisk -l /dev/sda
   sfdisk -l /dev/sdb
   smartctl -a /dev/hda
   smartctl -a /dev/hdc
   smartctl -a /dev/sda
   smartctl -a /dev/sdb
   switchboot -l
   system_check -d
   top -cb
   top -cb (text only)
   vgdisplay -vA
   vmstat
   who -aH
   Directory
   ls -alsR (critical files)
   Networking
   ifconfig -a
   ip -f dnet addr show
   ip -f inet addr show
   ip -f inet link show
   ip -f inet neigh show
   ip -f inet route show
   ip -f inet rule show
   ip -f inet tunnel show
   ip -f inet6 addr show
   ip -f inet6 link show
   ip -f inet6 neigh show
   ip -f inet6 route show
   ip -f inet6 tunnel show
   ip -f ipx addr show
   ip -f link addr show
   ip -f link link show
   ip -f link neigh show
   ip -f link route show
   ip -f link tunnel show
   lsof -n
   lsof -n (text only)
   netstat -nge
   netstat -ni
   netstat -nr
   netstat -pan[oT]
   netstat -sa
   TMOS
   /shared/bin/big3d -v
   /usr/sbin/big3d -v
   bigstart memstat
   bigtop -n -once
   createmanifest -d
   dag_read dump c2h
   dag_read dump dest
   dag_read dump hash
   dag_read dump irq_mask
   dag_read dump lkup
   dag_read dump pcnt
   dag_read dump pctl
   dag_read dump pmatch
   dag_read dump poverflow
   dag_read dump stats
   platform_check
   tmctl (global stats)
   tmctl (ICMP)
   tmctl (ICMP6)
   tmctl (IPv4)
   tmctl (IPv6)
   tmctl (TMM)
   tmctl -a (blade)
   tmctl -a (cluster)
   tmctl -d blade switch/cmp
   tmctl -d blade switch/vcmpsec
   tmctl memory
   tmctl mpi_conn_stat
   tmidiag -d
   tmidiag -l
   Utilities
   Engineering Hotfix Changes
   Hotfix Changes
   Public SSL Certificates
   Recreate Data Groups
   Virtual Server Traffic
