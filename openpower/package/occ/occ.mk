################################################################################
#
# occ for POWER9
#
################################################################################

OCC_VERSION_BRANCH_MASTER_P8 ?= 28f2cec690b7f19548ce860a8820f519e6c39a6a
OCC_VERSION_BRANCH_MASTER ?= 6c9f28ebe2596588ff6cc819bc4c2c158755ca43

OCC_VERSION ?= $(if $(BR2_OPENPOWER_POWER9),$(OCC_VERSION_BRANCH_MASTER),$(OCC_VERSION_BRANCH_MASTER_P8))
OCC_SITE = https://scm.raptorcs.com/scm/git/talos-occ
OCC_SITE_METHOD = git
OCC_LICENSE = Apache-2.0

OCC_LICENSE_FILES = LICENSE

OCC_INSTALL_IMAGES = YES
OCC_INSTALL_TARGET = NO

OCC_STAGING_DIR = $(STAGING_DIR)/occ

OCC_IMAGE_BIN_PATH = obj/image.bin

OCC_DEPENDENCIES_P8 = host-binutils host-p8-pore-binutils
OCC_DEPENDENCIES_P9 = host-binutils host-ppe42-gcc
OCC_DEPENDENCIES ?= $(if $(BR2_OPENPOWER_POWER9),$(OCC_DEPENDENCIES_P9),$(OCC_DEPENDENCIES_P8))

define OCC_BUILD_CMDS
	if [ "$(BR2_OCC_GPU_BIN_BUILD)" == "y"  ]; then \
	    cd $(@D)/src && \
            make PPE_TOOL_PATH=$(PPE42_GCC_BIN) OCC_OP_BUILD=1 CROSS_PREFIX=$(TARGET_CROSS) LD_LIBRARY_PATH=$(HOST_DIR)/usr/lib GPE1_BIN_IMAGE_PATH=$(STAGING_DIR)/hostboot_binaries/ OPOCC_GPU_SUPPORT=1 all; \
	else \
            cd $(@D)/src && \
            make PPE_TOOL_PATH=$(PPE42_GCC_BIN) OCC_OP_BUILD=1 CROSS_PREFIX=$(TARGET_CROSS) LD_LIBRARY_PATH=$(HOST_DIR)/usr/lib all; \
	fi;
endef
OCC_BUILD_CMDS ?= $(OCC_BUILD_CMDS_P9)

define OCC_INSTALL_IMAGES_CMDS
       mkdir -p $(STAGING_DIR)/occ
       cp $(@D)/$(OCC_IMAGE_BIN_PATH) $(OCC_STAGING_DIR)/$(BR2_OCC_BIN_FILENAME)
endef

$(eval $(generic-package))
