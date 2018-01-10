#!/bin/bash
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin || return 1
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1
make -C doc DESTDIR="$SHED_FAKEROOT" install-html docdir=/usr/share/doc/tar-1.30 || return 1
