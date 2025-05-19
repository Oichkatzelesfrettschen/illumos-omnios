LIBRARY=        libnetdrv.a
VERS=           .1
OBJECTS=        netdrv.o

include ../Makefile.lib
include ../Makefile.rootfs

LIBS=           $(DYNLIB)
SRCS=           $(OBJECTS:%.o=../common/%.c)

$(DYNLIB):      $(OBJECTS)
        $(LINK.c) -o $@ $(OBJECTS) -M ../common/mapfile-vers -ldoor $(LDLIBS)
        $(POST_PROCESS_SO)

pics/%.o:       ../common/%.c
        $(COMPILE.c) -o $@ $<
        $(POST_PROCESS_O)

CFLAGS +=       $(CCVERBOSE)
LDLIBS +=       -ldoor -lc

.KEEP_STATE:

all:    $(LIBS)

install: all $(ROOTLIBS) $(ROOTLINKS) $(ROOTLIBDIR)/$(DYNLIB)

include ../Makefile.targ
