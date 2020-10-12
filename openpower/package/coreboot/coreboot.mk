################################################################################
#
# hostboot for POWER9
#
################################################################################
COREBOOT_VERSION = $(call qstrip,$(BR2_COREBOOT_VERSION))
COREBOOT_SITE = https://github.com/3mdeb/coreboot.git
COREBOOT_SITE_METHOD = git

COREBOOT_LICENSE = GPLv2
COREBOOT_LICENSE_FILES = LICENSE
COREBOOT_DEPENDENCIES = host-binutils

COREBOOT_INSTALL_IMAGES = YES
COREBOOT_INSTALL_TARGET = NO

COREBOOT_ENV_VARS=$(TARGET_MAKE_ENV)

define COREBOOT_BUILD_CMDS
        $(COREBOOT_ENV_VARS) bash -c 'cd $(@D) && cp configs/$(call qstrip,$(BR2_COREBOOT_CONFIG_FILE)) .config && $(MAKE) olddefconfig && $(MAKE)'
endef

define COREBOOT_INSTALL_IMAGES_CMDS
        cd $(@D) && cp build/coreboot.rom $(STAGING_DIR)/coreboot_build_images/
endef

$(eval $(generic-package))
