require core-image-xfce.bb

DESCRIPTION = "Image with XCFE support that includes everything within \
core-image-sato plus meta-toolchain, development headers and libraries to \
form a standalone SDK."

IMAGE_FEATURES += "dev-pkgs tools-sdk tools-debug \
                   eclipse-debug tools-profile tools-testapps \
                   debug-tweaks ssh-server-openssh \
                  "

IMAGE_INSTALL += "kernel-devsrc packagegroup-core-buildessential-extended"
export IMAGE_BASENAME = "core-image-xfce-sdk"
