GENCCODE_ASSEMBLY_TYPE=-a gcc
SO=so
SOBJ=so
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=.58.2
COMPILE=/usr/bin/gcc-4.8 -isystem/home/linuxbrew/.linuxbrew/include -D_REENTRANT  -DU_HAVE_ELF_H=1 -DU_HAVE_ATOMIC=1 -DU_HAVE_STRTOD_L=1  -DU_ATTRIBUTE_DEPRECATED= -Os -w -pipe -march=core2 -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -c
LIBFLAGS=-I/home/linuxbrew/.linuxbrew/Cellar/icu4c/58.2/include -DPIC -fPIC
GENLIB=/usr/bin/gcc-4.8 -Os -w -pipe -march=core2 -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -L/home/linuxbrew/.linuxbrew/lib -Wl,--dynamic-linker=/home/linuxbrew/.linuxbrew/lib/ld.so -Wl,-rpath,/home/linuxbrew/.linuxbrew/lib  -shared -Wl,-Bsymbolic
LDICUDTFLAGS=-nodefaultlibs -nostdlib
LD_SONAME=-Wl,-soname -Wl,
RPATH_FLAGS=
BIR_LDFLAGS=-Wl,-Bsymbolic
AR=ar
ARFLAGS=r
RANLIB=ranlib
INSTALL_CMD=/usr/bin/install -c
