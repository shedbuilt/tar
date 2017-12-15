#!/bin/bash
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
make -C doc DESTDIR=${SHED_FAKEROOT} install-html docdir=/usr/share/doc/tar-1.29
