#!/bin/sh

usage() {
   echo "Usage: $0 nat_type"
   echo
   echo "where nat_type is one of the following,"
   echo "self-explaining, NAT types:"
   echo "  f)ullcone"
   echo "  r)estricted"
   echo "  p)ortrestricted"
   echo "  s)ymmetric"
}


if [ $# != 1 ]; then
   usage
   exit 1
fi

if [ "$1" != "f" -a "$1" != "fullcone" -a \
     "$1" != "r" -a "$1" != "restricted" -a \
     "$1" != "p" -a "$1" != "portrestricted" -a \
     "$1" != "s" -a "$1" != "symmetric" ]; then
   usage
   exit 1
fi


# Stop all pending rule expiry timers
killall sleep2 >& /dev/null

# Clear existing iptables rules from relevant chains
iptables --table nat --flush PREROUTING
iptables --table nat --flush POSTROUTING
/etc/init.d/ulogd stop >/dev/null


case $1 in
   f|fullcone)
      # Appear to the outside with fixed addresses
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.2 --jump SNAT --to-source 193.204.161.14
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.3 --jump SNAT --to-source 193.204.161.15

      iptables --table nat --append PREROUTING --in-interface eth1 --destination 193.204.161.14 --jump DNAT --to-destination 10.0.0.2
      iptables --table nat --append PREROUTING --in-interface eth1 --destination 193.204.161.15 --jump DNAT --to-destination 10.0.0.3
      ;;


   r|restricted)
      # Appear to the outside with fixed addresses
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.2 --jump SNAT --to-source 193.204.161.14
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.3 --jump SNAT --to-source 193.204.161.15

      # Monitor outgoing packets
      iptables --append FORWARD --source 10.0.0.0/24 --out-interface eth1 --jump ULOG
      rm -f /var/log/ulog/syslogemu.log
      mkfifo /var/log/ulog/syslogemu.log
      /etc/init.d/ulogd start >/dev/null &
      cat /var/log/ulog/syslogemu.log | awk -W interactive '
         {
            for (i=1; i<=NF; i++) {
               split($i,fields,"=")
               if (fields[1]=="DST") { dst=fields[2] }
               if (fields[1]=="PROTO") { proto=tolower(fields[2]) }
               if (fields[1]=="SRC") {
                  src=fields[2]
                  if (src=="10.0.0.2") { ext_src="193.204.161.14"; }
                  if (src=="10.0.0.3") { ext_src="193.204.161.15"; }
               }
            }
            system("/root/set_temp_iptables_rule.sh PREROUTING -s " dst " -d " ext_src " -p " proto " -i eth1 -j DNAT --to-destination " src " >& /dev/null")
         }' &
      ;;


   p|portrestricted)
      # Appear to the outside with fixed addresses
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.2 --jump SNAT --to-source 193.204.161.14
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.3 --jump SNAT --to-source 193.204.161.15

      # Monitor outgoing packets
      iptables --append FORWARD --source 10.0.0.0/24 --out-interface eth1 --jump ULOG
      rm -f /var/log/ulog/syslogemu.log
      mkfifo /var/log/ulog/syslogemu.log
      /etc/init.d/ulogd start >/dev/null &
      cat /var/log/ulog/syslogemu.log | awk -W interactive '
         {
            for (i=1; i<=NF; i++) {
               split($i,fields,"=")
               if (fields[1]=="DST") { dst=fields[2] }
               if (fields[1]=="SPT") { src_port=fields[2] }
               if (fields[1]=="DPT") { dst_port=fields[2] }
               if (fields[1]=="PROTO") { proto=tolower(fields[2]) }
               if (fields[1]=="SRC") {
                  src=fields[2]
                  if (src=="10.0.0.2") { ext_src="193.204.161.14"; }
                  if (src=="10.0.0.3") { ext_src="193.204.161.15"; }
               }
            }

            if (proto=="tcp" || proto=="udp") {
               # Here we assume that port preservation is enforced (i.e.,
               # port numbers are not NATed
               system("/root/set_temp_iptables_rule.sh PREROUTING -s " dst " -d " ext_src " -p " proto " --sport " dst_port "  -i eth1 -j DNAT --to-destination " src " >& /dev/null")
            }
         }' &
     ;;


   s|symmetric)
      # Appear to the outside with fixed addresses
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.2 --destination 193.204.161.65 --jump SNAT --to-source 193.204.161.14
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.2 --destination 193.204.161.103 --jump SNAT --to-source 193.204.161.15
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.3 --destination 193.204.161.65 --jump SNAT --to-source 193.204.161.16
      iptables --table nat --append POSTROUTING --out-interface eth1 --source 10.0.0.3 --destination 193.204.161.103 --jump SNAT --to-source 193.204.161.17
      ;;


   *)
      usage
      exit 1
      ;;
esac

