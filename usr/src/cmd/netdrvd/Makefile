include ../Makefile.cmd

PROG = netdrvd

SRCS = netdrvd.c

CFLAGS += $(CCVERBOSE)
LDLIBS += -ldoor

.KEEP_STATE:

all: $(PROG)

install: all $(ROOTLIBPROG)

clean:
$(RM) $(PROG) $(OBJS)

include ../Makefile.targ
