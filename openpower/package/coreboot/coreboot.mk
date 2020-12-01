################################################################################
#
# coreboot for POWER9
#
################################################################################
COREBOOT_VERSION = $(call qstrip,$(BR2_COREBOOT_VERSION))
COREBOOT_SITE = https://github.com/3mdeb/coreboot.git
COREBOOT_SITE_METHOD = git
COREBOOT_GIT_SUBMODULES = YES

COREBOOT_LICENSE = GPLv2
COREBOOT_LICENSE_FILES = LICENSE
COREBOOT_DEPENDENCIES = host-binutils host-libopenssl

COREBOOT_INSTALL_IMAGES = YES
COREBOOT_INSTALL_TARGET = NO

COREBOOT_ENV_VARS = $(TARGET_MAKE_ENV)
COREBOOT_ENV_VARS += \
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(HOST_DIR)/lib/pkgconfig:$(HOST_DIR)/share/pkgconfig"

define COREBOOT_BUILD_CMDS
    $(COREBOOT_ENV_VARS) bash -c 'cd $(@D) && $(MAKE) crossgcc-ppc64 CPUS=8 && cp configs/$(call qstrip,$(BR2_COREBOOT_CONFIG_FILE)) .config && $(MAKE) olddefconfig && $(MAKE) V=1'
endef

define COREBOOT_INSTALL_IMAGES_CMDS
	mkdir -p $(STAGING_DIR)/coreboot_build_images/ && \
	cp $(@D)/build/coreboot.rom  $(STAGING_DIR)/coreboot_build_images/ && \
	cp $(@D)/build/cbfs/fallback/bootblock.bin  $(STAGING_DIR)/coreboot_build_images/
endef

$(eval $(generic-package))
