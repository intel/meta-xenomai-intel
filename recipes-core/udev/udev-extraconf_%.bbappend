# Freescale Xenomai x86_64 extra configuration udev rules
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_intel-x86-common = " file://blacklist.conf "

do_install_prepend () {
    if [ -e "${WORKDIR}/blacklist.conf" ]; then
        install -d ${D}${sysconfdir}/modprobe.d
        install -m 0644 ${WORKDIR}/blacklist.conf ${D}${sysconfdir}/modprobe.d
    fi
}

FILES_${PN}_append = " ${sysconfdir}/modprobe.d"

PACKAGE_ARCH_intel-x86-common = "${MACHINE_ARCH}"
