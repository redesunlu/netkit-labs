# Laboratorios de Netkit
Este repositorio contiene laboratorios de [Netkit-NG](https://netkit-ng.github.io/) adaptados para la cátedra de [Teleinformática y Redes](http://www.labredes.unlu.edu.ar/tyr), Universidad Nacional de Luján, Argentina.

Estos laboratorios están listos para integrarse con un filesystem y kernel de Netkit-NG generados mediante el fork de [Netkit-NG-build](https://github.com/netkit-ng/netkit-ng-build) mantenido en este mismo grupo: https://github.com/redesunlu/netkit-ng-build.

El filesystem generado con este fork, además de utilizar mirrors de Debian en Argentina para hacer el build más rápido, incorpora algunos paquetes que no están en el listado de paquetes de la imagen de Netkit-NG original. De esta manera, los laboratorios de este repositorio funcionan adecuadamente.

# Contenido

Este repositorio cuenta con los siguientes laboratorios:

 * [Laboratorio de Telnet](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_telnet-TYR.tar.gz?raw=true): Es un laboratorio de Telnet sencillo en el cual hay que ejecutar comandos en un servidor remoto.
 * [Laboratorio de DNS](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_dns-TYR.tar.gz?raw=true): Es un fork con muy pocas modificaciones del [laboratorio oficial de DNS](http://wiki.netkit.org/netkit-labs/netkit-labs_application-level/netkit-lab_dns/netkit-lab_dns.tar.gz) de Netkit, compatible para su uso con Netkit-NG.
 * [Laboratorio de Email](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_email.tar.gz?raw=true): Es un fork con muy pocas modificaciones del [laboratorio oficial de Email](http://wiki.netkit.org/netkit-labs/netkit-labs_application-level/netkit-lab_email/netkit-lab_email.tar.gz) de Netkit, compatible para su uso con Netkit-NG.
 * [Laboratorio de Proxy HTTP](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_proxy-TYR.tar.gz?raw=true): Es un fork con pocas modificaciones del [laboratorio oficial de Webserver](http://wiki.netkit.org/netkit-labs/netkit-labs_application-level/netkit-lab_webserver/netkit-lab_webserver.tar.gz) de Netkit, compatible para su uso con Netkit-NG.
 * [Laboratorio de Ruteo Dinámico con Quagga](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_quagga-TYR.tar.gz?raw=true): Es un fork con pocas modificaciones del [laboratorio oficial de Zebra/Quagga](http://wiki.netkit.org/netkit-labs/netkit-labs_basic-topics/netkit-lab_quagga/netkit-lab_quagga.tar.gz) de Netkit, compatible para su uso con Netkit-NG.
 * [Laboratorio de Ruteo Dinámico con RIP](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_rip-TYR.tar.gz?raw=true): Es un fork con pocas modificaciones del [laboratorio oficial de RIP](http://wiki.netkit.org/netkit-labs/netkit-labs_basic-topics/netkit-lab_rip/netkit-lab_rip.tar.gz) de Netkit, compatible para su uso con Netkit-NG.
 * [Laboratorio de SNMPv2](https://github.com/redesunlu/netkit-labs/blob/master/tarballs/netkit-lab_snmpv2-TYR.tar.gz?raw=true): Este es un laboratorio en el cual debe monitorearse y controlarse un router mediante protocolo SNMPv2.
