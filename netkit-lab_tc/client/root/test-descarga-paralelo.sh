#!/bin/sh

set -e

colorecho () {
    printf "\033[92m$1\033[0m\n"
}

colorecho "Test de tasa de descarga en paralelo ..."
echo "Test de tasa de descarga en paralelo ..." > /tmp/netperf_test_0.txt

# test download capacity (client --<<-- server) on port 80
echo -e "\nMidiendo tasa de descarga desde el servidor web, puerto 80" > /tmp/netperf_test_1.txt
netperf -t TCP_MAERTS -H www -- -P 1024,80 -s 1M -S 1M >> /tmp/netperf_test_1.txt &

# test download capacity (client --<<-- server) on port 25
echo -e "\nMidiendo tasa de descarga desde el servidor de correo, puerto 25" > /tmp/netperf_test_2.txt
netperf -t TCP_MAERTS -H mail -- -P 1024,25 -s 1M -S 1M >> /tmp/netperf_test_2.txt &

# test download capacity (client --<<-- server) on port 5432
echo -e "\nMidiendo tasa de descarga desde el servidor de base de datos, puerto 5432" > /tmp/netperf_test_3.txt
netperf -t TCP_MAERTS -H database -- -P 1024,5432 -s 1M -S 1M >> /tmp/netperf_test_3.txt &

# test upload capacity (client -->>-- server) on port 5432
echo -e "\nMidiendo tasa de subida hacia el servidor de base de datos, puerto 5432" > /tmp/netperf_test_4.txt
netperf -t TCP_STREAM -H database -- -P 1024,5432 -s 1M -S 1M >> /tmp/netperf_test_4.txt

sleep 2

cat /tmp/netperf_test_?.txt

