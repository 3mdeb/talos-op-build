# OpenPOWER Firmware Build Environment

The OpenPOWER firmware build process uses Buildroot to create a toolchain and
build the various components of the PNOR firmware, including Hostboot, Skiboot,
OCC, Petitboot etc.

## Documentation

https://open-power.github.io/op-build/

See the doc/ directory for documentation source. Contributions
are *VERY* welcome!

## Development

Issues, Milestones, pull requests and code hosting is on GitHub:
https://github.com/open-power/op-build

See [CONTRIBUTING.md](CONTRIBUTING.md) for howto contribute code.

* Mailing list: openpower-firmware@lists.ozlabs.org
* Info/Subscribe: https://lists.ozlabs.org/listinfo/openpower-firmware  
* Archives: https://lists.ozlabs.org/pipermail/openpower-firmware/

## Building an image

To build an image for a Talos system:

```
git clone --recursive git@github.com:open-power/op-build.git
cd op-build
. op-build-env
op-build talos_defconfig && op-build
```

There are also default configurations for other platforms in
`openpower/configs/`. Current POWER8 platforms include Habanero,
Firestone, and Garrison. Current POWER9 platforms include Witherspoon,
Boston (p9dsu), Romulus, and Zaius.

Buildroot/op-build supports both native and cross-compilation - it will
automatically download and build an appropriate toolchain as part of the build
process, so you don't need to worry about setting up a
cross-compiler.  Compiling from an OpenPOWER host is officially supported.

### Dependencies for 64-bit little endian Debian systems

1. Install Debian (>= 9.0).
2. Install the packages necessary for the build:

        sudo apt-get install cscope ctags libz-dev libexpat-dev \
          python language-pack-en texinfo \
          build-essential g++ git bison flex unzip \
          libssl-dev libxml-simple-perl libxml-sax-perl libxml2-dev libxml2-utils xsltproc \
          wget bc
