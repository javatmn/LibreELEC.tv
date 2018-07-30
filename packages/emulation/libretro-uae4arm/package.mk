# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-uae4arm"
PKG_VERSION="0e9dd6e"
PKG_SHA256="ccc989c75c11cbc1be96b917cadc3551b5fb8710f2a203f2ce86c46196229a4a"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/uae4arm-libretro"
PKG_URL="https://github.com/libretro/uae4arm-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="uae4arm-libretro-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_LONGDESC="UAE4ARM amiga emulator."

PKG_LIBNAME="uae4arm_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="UAE4ARM_LIB"

pre_configure_target() {
  if target_has_feature neon; then
    CFLAGS="$CFLAGS -D__NEON_OPT"
  fi
}

make_target() {
  make HAVE_NEON=1 USE_PICASSO96=1
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
