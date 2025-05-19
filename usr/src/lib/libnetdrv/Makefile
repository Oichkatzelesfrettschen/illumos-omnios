include ../Makefile.lib

SUBDIRS = $(MACH)
$(BUILD64)SUBDIRS += $(MACH64)

all :=          TARGET= all
clean :=        TARGET= clean
clobber :=      TARGET= clobber
install :=      TARGET= install

.KEEP_STATE:

all clean clobber install: $(SUBDIRS)

$(SUBDIRS): FRC
@cd $@; pwd; $(MAKE) $(TARGET)

FRC:
