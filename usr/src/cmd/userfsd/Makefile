include ../Makefile.cmd

PROG = userfsd

SRCS = userfsd.c

CFLAGS += $(CCVERBOSE)
LDLIBS += -ldoor

.KEEP_STATE:

all: $(PROG)

install: all $(ROOTLIBPROG)

clean:
$(RM) $(PROG) $(OBJS)

include ../Makefile.targ
