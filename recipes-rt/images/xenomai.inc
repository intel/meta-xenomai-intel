DESCRIPTION = "Additional packages for Linux Xenomai 3.0.x Real-Time Extension(RTE)"

inherit systemd-sysusers

IMAGE_INSTALL_append = " xenomai"
