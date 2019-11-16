DESCRIPTION = "Additional packages for Linux Xenomai 3.0.x Real-Time Extension(RTE)"

inherit systemd-sysusers

IMAGE_INSTALL_append = " xenomai"
IMAGE_INSTALL_append = " init-ifupdown"
IMAGE_INSTALL_append = " udev-extraconf"
