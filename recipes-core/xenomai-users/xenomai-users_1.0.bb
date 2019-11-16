SUMMARY = "Set admin + user"
SECTION = "USR"
LICENSE = "CLOSED"

inherit useradd

# how to
# pw: abc
# at bash: usermod -p $(openssl passwd abc) root
# get a salted hash: openssl passwd abc
# one possible result: 1Cw5PHLy76ps2
# the command now looks: usermod -p 1Cw5PHLy76ps2 root

# set image root password
#EXTRA_USERS_PARAMS = "usermod -p intellab root;"

USERADD_PACKAGES = "${PN}"

# password
# "xyz"
# openssl passwd xyz
# result: y5UyLBO4GNAwc

USERADD_PARAM_${PN} = "-u 1200 -d /home/intel -r -s /bin/bash -p intellab intel"

do_install_append () {
    install -d -m 755 ${D}${datadir}/intel

    # The new users and groups are created before the do_install
    # step, so you are now free to make use of them:
    chown -R intel ${D}${datadir}/intel

    # groups
    #chgrp -R xenomai sudo ${D}${datadir}/intel
}

FILES_${PN} = "${datadir}/*"

#ALLOW_EMPTY_${PN} = "1"