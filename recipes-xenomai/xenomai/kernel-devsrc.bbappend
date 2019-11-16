inherit linux-kernel-base

S = "${STAGING_KERNEL_DIR}"
B = "${STAGING_KERNEL_BUILDDIR}"

KERNEL_VERSION = "${@get_kernelversion_headers('${S}')}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install() {
        kerneldir=${D}${KERNEL_SRC_PATH}
        install -d $kerneldir

        #
        # Copy the staging dir source (and module build support) into the devsrc structure.
        # We can keep this copy simple and take everything, since a we'll clean up any build
        # artifacts afterwards, and the extra i/o is not significant
        #
        cd ${B}
        find . -type d -name '.git*' -prune -o -path '.debug' -prune -o -type f -print0 | cpio --null -pdlu $kerneldir
        cd ${S}
	find . -type d -name '.git*' -prune -o -type d -name '.kernel-meta' -prune -o -type f -print0 | cpio --null -pdlu $kerneldir

        #
        # Copy the Xenomai staging dir source into the devsrc structure.
        #
        install -d $kerneldir/arch/${ARCH}/xenomai
	#find ./arch/${ARCH}/xenomai -print0 | cpio --null -pdlu $kerneldir
	cp -rL ./arch/${ARCH}/xenomai $kerneldir/arch/${ARCH}

        install -d $kerneldir/include/xenomai
	#find ./include/xenomai -print0 | cpio --null -pdlu $kerneldir
	cp -rL ./include/xenomai $kerneldir/include

        install -d $kerneldir/include/asm-generic/xenomai
	#find ./include/asm-generic/xenomai -print0 | cpio --null -pdlu $kerneldir
	cp -rL ./include/asm-generic/xenomai $kerneldir/include/asm-generic

        install -d $kerneldir/include/linux/xenomai
	#find ./include/linux/xenomai -print0 | cpio --null -pdlu $kerneldir/
	cp -rL ./include/linux/xenomai $kerneldir/include/linux

        install -d $kerneldir/drivers/xenomai
	#find ./drivers/xenomai -print0 | cpio --null -pdlu $kerneldir
	cp -rL ./drivers/xenomai $kerneldir/drivers

        install -d $kerneldir/kernel/xenomai
	#find ./kernel/xenomai -print0 | cpio --null -pdlu $kerneldir
	cp -rL ./kernel/xenomai $kerneldir/kernel

        # Explicitly set KBUILD_OUTPUT to ensure that the image directory is cleaned and not
        # The main build artifacts. We clean the directory to avoid QA errors on mismatched
        # architecture (since scripts and helpers are native format).
        KBUILD_OUTPUT="$kerneldir"
        oe_runmake -C $kerneldir CC="${KERNEL_CC}" LD="${KERNEL_LD}" clean _mrproper_scripts
        # make clean generates an absolute path symlink called "source"
        # in $kerneldir points to $kerneldir, which doesn't make any
        # sense, so remove it.
        if [ -L $kerneldir/source ]; then
            bbnote "Removing $kerneldir/source symlink"
            rm -f $kerneldir/source
        fi

        # As of Linux kernel version 3.0.1, the clean target removes
        # arch/powerpc/lib/crtsavres.o which is present in
        # KBUILD_LDFLAGS_MODULE, making it required to build external modules.
        if [ ${ARCH} = "powerpc" ]; then
                mkdir -p $kerneldir/arch/powerpc/lib/
                cp ${B}/arch/powerpc/lib/crtsavres.o $kerneldir/arch/powerpc/lib/crtsavres.o
        fi

        # Remove fixdep/objtool as they won't be target binaries
        for i in fixdep objtool; do
                if [ -e $kerneldir/tools/objtool/$i ]; then
                        rm -rf $kerneldir/tools/objtool/$i
                fi
        done

        chown -R root:root ${D}
}

do_install_append() {
    oe_runmake -C ${kerneldir}/tools/objtool clean -i
}