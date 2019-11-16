LICENSE = "MIT"
DESCRIPTION = "Image with XFCE, a desktop environment and visual style for \
mobile devices. The image supports X11 with a XFCE theme, Pimlico \
applications, and contains terminal, editor, and file manager."

inherit distro_features_check
REQUIRED_DISTRO_FEATURES = "x11"

IMAGE_FEATURES += "splash package-management x11-base ssh-server-dropbear hwcodecs"

IMAGE_INSTALL = "packagegroup-core-boot \
                 packagegroup-core-x11 \
                 packagegroup-xfce-base \
                 kernel-modules \
                 packagegroup-base \
                 packagegroup-core-devtools \
                 packagegroup-core-graphics-essential \
                "

IMAGE_LINGUAS ?= " "
export IMAGE_BASENAME = "core-image-xfce"

inherit core-image

TOOLCHAIN_HOST_TASK_append = " nativesdk-intltool nativesdk-glib-2.0"
TOOLCHAIN_HOST_TASK_remove_task-populate-sdk-ext = " nativesdk-intltool nativesdk-glib-2.0"

require xenomai.inc
