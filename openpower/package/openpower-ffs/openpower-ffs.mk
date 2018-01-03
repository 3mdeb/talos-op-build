OPENPOWER_FFS_VERSION ?= 3ec70fbc458e32eef0d0b1de79688b4dc48cbd57
OPENPOWER_FFS_SITE ?= https://scm.raptorcs.com/scm/git/ffs
OPENPOWER_FFS_SITE_METHOD = git
OPENPOWER_FFS_LICENSE = Apache-2.0
OPENPOWER_FFS_LICENSE_FILES = LICENSE

OPENPOWER_FFS_AUTORECONF = YES
OPENPOWER_FFS_AUTORECONF_OPTS = -i

$(eval $(host-autotools-package))
