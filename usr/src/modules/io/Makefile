# Top-level Makefile for driver modules under usr/src/modules/io
SUBDIRS := $(wildcard */.)

.PHONY: all clean install $(SUBDIRS)

all clean install:
	@for dir in $(wildcard */.); do \
		if [ -d $${dir} ]; then \
			$(MAKE) -C $${dir} $@ || exit $$?; \
		fi; \
	done
