FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LINUX_VERSION = "4.14.68"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://include/COPYING;md5=79ed705ccb9481bf9e7026b99f4e2b0e"

SECTION = "xenomai"
HOMEPAGE = "http://www.xenomai.org/"

PR = "r0"
SRC_URI_append = " \
          file://xenomai3.scc \
          file://rtnet_rootfs.scc \
	  "

SRC_URI += "https://gitlab.denx.de/Xenomai/xenomai/-/archive/v${PV}/xenomai-v${PV}.tar.gz;"
SRC_URI[md5sum] = "be136055aa7e7f282a27f61ce1e27827"

S = "${WORKDIR}/${PN}-v${PV}"

inherit autotools pkgconfig

prefix="/usr/xenomai"
exec_prefix="/usr/xenomai"
libdir="/usr/xenomai/lib"
datarootdir="${prefix}/share"
datadir="/usr/xenomai/share"
pkgdatadir="${datadir}/xenomai"
includedir="/usr/xenomai/include"

EXTRA_OECONF += "--enable-smp \
                --with-core=cobalt \
		--enable-pshared"

#Add directories to package for shipping
FILES_${PN} += "/dev/"
FILES_${PN} += "/etc/"
FILES_${PN} += "/usr/xenomai/*"

INSANE_SKIP_${PN} += "ldflags"

SYSROOT_DIRS += "${bindir}"

sysroot_stage_all_append() {
  install -d ${SYSROOT_DESTDIR}${bindir}
  install -m 0755 ${D}${bindir}/xeno-config ${SYSROOT_DESTDIR}${bindir}/xeno-config
}