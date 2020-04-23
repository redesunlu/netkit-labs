#!/bin/sh

set -e

colorecho () {
    printf "\033[92m$1\033[0m\n"
}

echo "Test de tasa de descarga en serie ..."

# test download capacity (client --<<-- server) on port 80
colorecho "\nMidiendo tasa de descarga desde el servidor web, puerto 80"
netperf -t TCP_MAERTS -H www -- -P 1024,80 -s 1M -S 1M

# test download capacity (client --<<-- server) on port 25
colorecho "\nMidiendo tasa de descarga desde el servidor de correo, puerto 25"
netperf -t TCP_MAERTS -H mail -- -P 1024,25 -s 1M -S 1M

# test download capacity (client --<<-- server) on port 5432
colorecho "\nMidiendo tasa de descarga desde el servidor de base de datos, puerto 5432"
netperf -t TCP_MAERTS -H database -- -P 1024,5432 -s 1M -S 1M

# test upload capacity (client -->>-- server) on port 5432
colorecho "\nMidiendo tasa de subida hacia el servidor de base de datos, puerto 5432"
netperf -t TCP_STREAM -H database -- -P 1024,5432 -s 1M -S 1M

