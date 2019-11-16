SUMMARY="Install and start rtnet service"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LINUX_VERSION = "4.14.68"
LICENSE="CLOSED"


SRC_URI = "file://rtnet.service"

S = "${WORKDIR}"
inherit systemd

SYSTEMD_PACKAGES = "${PN}"
SYTEMD_SERVIE_${PN}="rtnet.service"

do_install(){
	install -d ${D}${systemd_system_unitdir}
	install -m 0755 ${WORKDIR} ${D}/usr/local/rtnet
}


FILES_${PN} += "rtnet.service"
