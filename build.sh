#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_PREFIX='/usr'
SHED_PKG_LOCAL_BINDIR='/bin'
if [ -n "${SHED_PKG_LOCAL_OPTIONS[toolchain]}" ]; then
    SHED_PKG_LOCAL_PREFIX='/tools'
    SHED_PKG_LOCAL_BINDIR='/tools/bin'
fi
SHED_PKG_LOCAL_DOCDIR="${SHED_PKG_LOCAL_PREFIX}/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}"
# Configure
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=$SHED_PKG_LOCAL_PREFIX \
            --bindir=$SHED_PKG_LOCAL_BINDIR &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    make DESTDIR="$SHED_FAKE_ROOT" -C doc install-html docdir=$SHED_PKG_LOCAL_DOCDIR
fi
