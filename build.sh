#!/bin/bash
case "$SHED_BUILD_MODE" in
    toolchain)
        FORCE_UNSAFE_CONFIGURE=1 \
        ./configure --prefix=/tools || return 1
        ;;
    *)
        FORCE_UNSAFE_CONFIGURE=1  \
        ./configure --prefix=/usr \
                    --bindir=/bin || return 1
        ;;
esac
make -j $SHED_NUM_JOBS || return 1
make DESTDIR="$SHED_FAKE_ROOT" install || return 1

if [ "$SHED_BUILD_MODE" != 'toolchain' ]; then
    make -C doc DESTDIR="$SHED_FAKE_ROOT" install-html docdir=/usr/share/doc/tar-1.30 || return 1
fi
