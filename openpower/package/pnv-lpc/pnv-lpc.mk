################################################################################
#
# pnv-lpc - builds lpc utility from skiboot source
#
################################################################################

PNV_LPC_VERSION = 2d1519ef16b773401ddcc532592505f1251c82e4
PNV_LPC_SITE = https://scm.raptorcs.com/scm/git/talos-skiboot
PNV_LPC_SITE_METHOD = git

PNV_LPC_INSTALL_TARGET = YES

PNV_LPC_LICENSE_FILES = LICENCE

PNV_LPC_MAKE_OPTS += CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		     AS="$(TARGET_AS)" AR="$(TARGET_AR)" NM="$(TARGET_NM)" \
		     OBJCOPY="$(TARGET_OBJCOPY)" OBJDUMP="$(TARGET_OBJDUMP)" \
		     SIZE="$(TARGET_CROSS)size"

PNV_LPC_MAKE_ENV = \
	SKIBOOT_VERSION=$(PNV_LPC_VERSION) \
	       $(MAKE1) $(PNV_LPC_MAKE_OPTS) CROSS_COMPILE=$(TARGET_CROSS)


define PNV_LPC_BUILD_CMDS
	PREFIX=$(STAGING_DIR)/usr $(PNV_LPC_MAKE_ENV) -C $(@D)/external/lpc
endef

define PNV_LPC_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/external/lpc/lpc $(TARGET_DIR)/sbin/pnv-lpc
	$(INSTALL) -D $(@D)/external/lpc/devmem-aspeed $(TARGET_DIR)/sbin/devmem-aspeed
endef

$(eval $(generic-package))
