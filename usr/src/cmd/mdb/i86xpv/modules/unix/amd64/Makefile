#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#
# Copyright 2019 Joyent, Inc.

MODULE = unix.so
MDBTGT = kvm

MODSRCS = unix.c i86mmu.c sec.c xcall.c
MODASMSRCS = unix_sup.S

include ../../../../../Makefile.cmd
include ../../../../../Makefile.cmd.64
include ../../../../intel/Makefile.amd64
include ../../../Makefile.i86xpv
include ../../../../Makefile.module

MODSRCS_DIR = ../../../../i86pc/modules/unix/

CPPFLAGS += -DMP -D_MACHDEP -D__xpv
CPPFLAGS += -I../../../../common
CPPFLAGS += -I../../../../intel
CPPFLAGS += -I$(SRC)/uts/common
CPPFLAGS += -I$(SRC)/uts/i86xpv
CPPFLAGS += -I$(SRC)/uts/i86pc
CPPFLAGS += -I$(SRC)/uts/intel

CERRWARN += -_gcc=-Wno-char-subscripts
CERRWARN += -_gcc=-Wno-parentheses
CERRWARN += -_gcc=-Wno-unused-label
CERRWARN += $(CNOWARN_UNINIT)

CERRWARN += -_gcc=-Wno-unused-function
