#!/bin/sh
#
# nf_patch.sh
# replaces nf_conntrack.ko module to fix crash when using netfilter/iptables
#

FIX_DIR=$(dirname "$0")
BUGGY_HASH=8d901f15a29d42e1c84199060eaa72ab6adf260836ef36119242e72cdd4d52b6
FIXED_HASH=65047996b32cc35f4d56a1ced1cb1e7e0231b54274ab10544a9a834966b280d1
NETFILTER_DIR=/lib/modules/3.2.86-netkit-ng-K3.2/kernel/net/netfilter

CURRENT_HASH=$(sha256sum "${NETFILTER_DIR}/nf_conntrack.ko" | cut -d' ' -f1)

if [ "${CURRENT_HASH}" = "${BUGGY_HASH}" ]; then
    echo "Found buggy nf_conntrack.ko module"
    echo "Replacing it with a fixed module ..."
    rmmod nf_conntrack 2> /dev/null
    cd "${NETFILTER_DIR}"
    mv nf_conntrack.ko nf_conntrack.ko.buggy
    cp "$FIX_DIR/nf_conntrack.ko" nf_conntrack.ko.fixed
    cp nf_conntrack.ko.fixed nf_conntrack.ko
    modprobe nf_conntrack
    echo "Module nf_conntrack.ko installed and reloaded. Have fun!"
elif [ "${CURRENT_HASH}" = "${FIXED_HASH}" ]; then
    echo "Found fixed nf_conntrack.ko module. All good!"
else
    echo "Unknown nf_conntrack.ko module."
    echo "If you experience a crash when trying to define netfilter rules,"
    echo "please test the following commands before trying again."
    echo
    echo "    rmmod nf_conntrack"
    echo "    insmod $FIX_DIR/nf_conntrack.ko"
    echo
fi
