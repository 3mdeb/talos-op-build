################################################################################
#
# ppe42-binutils
#
################################################################################

PPE42_BINUTILS_VERSION ?= ded0eff199fa1d9bd8be5a78935e8f023a2c5fad
PPE42_BINUTILS_SITE ?= $(call github,open-power,ppe42-binutils,$(PPE42_BINUTILS_VERSION))
PPE42_BINUTILS_LICENSE = GPLv3+

PPE42_BINUTILS_DEPENDENCIES = host-binutils

PPE42_BINUTILS_DIR = $(STAGING_DIR)/ppe42-binutils
PPE42_BINUTILS_BIN = $(STAGING_DIR)/ppe42-binutils/linux

define HOST_PPE42_BINUTILS_BUILD_CMDS
        cd $(@D) && \
        ./configure --prefix=$(PPE42_BINUTILS_DIR) \
                    --exec-prefix=$(PPE42_BINUTILS_BIN) \
					--target=powerpc-eabi \
					--enable-shared \
					--enable-64-bit-bfd \
					&& \
        $(MAKE) configure-host && \
        $(MAKE) LDFLAGS=-all-static CFLAGS=-Wno-error
endef

define HOST_PPE42_BINUTILS_INSTALL_CMDS
        bash -c 'cd $(@D) && make install'
endef

$(eval $(host-generic-package))
