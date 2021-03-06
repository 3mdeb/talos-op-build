################################################################################
#
#  sb-signing-framework
#
################################################################################

SB_SIGNING_FRAMEWORK_SITE ?= https://scm.raptorcs.com/scm/git/sb-signing-framework
SB_SIGNING_FRAMEWORK_SITE_METHOD = git

SB_SIGNING_FRAMEWORK_LICENSE = Apache-2.0
SB_SIGNING_FRAMEWORK_LICENSE_FILES = LICENSE
SB_SIGNING_FRAMEWORK_VERSION ?= 02ed29aa11136a6d9a6e1f075772532c43cb7289

HOST_SB_SIGNING_FRAMEWORK_DEPENDENCIES = host-openssl

define HOST_SB_SIGNING_FRAMEWORK_BUILD_CMDS
	CFLAGS="-I $(HOST_DIR)/usr/include -Wl,-rpath -Wl,$(HOST_DIR)/usr/lib" \
		$(HOST_MAKE_ENV) $(MAKE) -C $(@D)/src/client/
endef

define HOST_SB_SIGNING_FRAMEWORK_COPY_FILES
		$(INSTALL) -m 0755 $(@D)/src/client/sf_client $(HOST_DIR)/usr/bin/
endef

HOST_SB_SIGNING_FRAMEWORK_POST_INSTALL_HOOKS += HOST_SB_SIGNING_FRAMEWORK_COPY_FILES

$(eval $(host-generic-package))

