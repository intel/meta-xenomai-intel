SUMMARY=" xenomai init service"
DESCRIPTION = "Script to do any first boot init, started as a systemd service which removes itself once finished"
LICENSE="CLOSED"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI =  " \
    file://xenomai-initscript.sh \
    file://xenomai-init.service \
"

S = "${WORKDIR}"
inherit systemd

do_install(){
	install -d ${D}/${sbindir}
    	install -m 0755 ${WORKDIR}/xenomai-initscript.sh ${D}/${sbindir}

    	install -d ${D}${systemd_unitdir}/system/
    	install -m 0644 ${WORKDIR}/xenomai-init.service ${D}${systemd_unitdir}/system
}

NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "xenomai-init.service"

inherit allarch systemd
