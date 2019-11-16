FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LINUX_VERSION = "4.14.68"
LICENSE="GPLv2"

PR="r0"
SRC_URI_append = " \
	file://tracing.scc \
	file://ipipe-4.14_base.scc \
	file://cobalt.scc \
	file://xddp.scc \
	file://rtnet.scc \
	file://common.scc \
	file://patches/xenomai-stable-3.0.x.tgz \	
	"

SRC_URI += "https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.0.7/xenomai-v3.0.7.tar.gz;"
SRC_URI[md5sum] = "be136055aa7e7f282a27f61ce1e27827"

do_patch_xenomai(){
        #patch xenomai source directory
        cd ${WORKDIR}/xenomai-v3.0.7
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0001-can-Fix-compiler-warning-about-missing-braces.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0002-cobalt-posix-signal-Plug-leak-of-pending-signal-stru.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0003-net-Split-internal-rtnet.h-and-install-rtdm-net.h-an.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0004-drivers-can-Add-PCAN-PCI-Express-OEM-ID.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0005-cobalt-kernel-always-use-explicit-preprocessor-condi.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0006-cobalt-x86-add-support-for-eager-fpu-handling.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0007-cobalt-x86-add-ipipe-4.4-eager-fpu-support.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0008-cobalt-fixup-for-kernel-4.14.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0009-cobalt-x86-add-ipipe-4.14-eager-fpu-support.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0010-cobalt-use-generic-linux-uaccess.h-header.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0011-drivers-analogy-Fix-improper-memset-in-Intel-8255.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0012-demo-cyclictest-turn-on-FIFO-mode-by-default-detecti.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0013-cobalt-thread-handle-case-of-invalid-domain-migratio.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0014-cobalt-intr-IRQ-affinity-depends-on-xnsched_realtime.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0015-cobalt-sched-fix-mismatches-between-supported-CPUs-a.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0016-demo-cyclictest-fix-time-delta-calculation.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0017-cobalt-posix-mqueue-Fix-crash-after-failing-registra.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0018-boilerplate-setup-cobalt-do-not-advertise-non-RT-CPU.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0019-Add-the-xsc-field-when-rtps-reads-the-sched-acct-fil.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0020-vxworks-mempart-fix-error-status-upon-failure-to-cre.patch
        patch -p1 < ${WORKDIR}/xenomai-stable-3.0.x/0021-Rename-__clz-to-xenomai_count_leading_zeros.patch
}

do_prepare_kernel(){
        #Set the linux kernel source directory
        linux_src="${S}"

        #Set xenomai source directory
        xenomai_src="${WORKDIR}/xenomai-v3.0.7"

        #Prepare kernel
        ${xenomai_src}/scripts/prepare-kernel.sh --arch=x86_64 --linux=${linux_src}
}

addtask do_patch_xenomai after do_patch before do_prepare_kernel
addtask do_prepare_kernel after do_patch before do_configure
