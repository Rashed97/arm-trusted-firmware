#
# Copyright (c) 2013-2014, ARM Limited and Contributors. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# Neither the name of ARM nor the names of its contributors may be used
# to endorse or promote products derived from this software without specific
# prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

vpath			%.c	common				\
				lib				\
				plat/${PLAT}			\
				plat/${PLAT}/${ARCH}		\
				arch/${ARCH}

vpath			%.S	lib/arch/${ARCH}		\
				include				\
				lib/sync/locks/exclusive	\
				common/${ARCH}

BL32_SOURCES		+=	tsp_entrypoint.S		\
				tsp_main.c			\
				tsp_request.S			\
				spinlock.S			\
				early_exceptions.S

BL32_LINKERFILE		:=	tsp.ld.S

vpath %.ld.S ${BL32_ROOT}
vpath %.c ${BL32_ROOT}
vpath %.c ${BL32_ROOT}/${ARCH}
vpath %.S ${BL32_ROOT}/${ARCH}

# Include the platform-specific TSP Makefile
# If no platform-specific TSP Makefile exists, it means TSP is not supported
# on this platform.
TSP_PLAT_MAKEFILE := bl32/tsp/tsp-${PLAT}.mk
ifeq (,$(wildcard ${TSP_PLAT_MAKEFILE}))
  $(error TSP is not supported on platform ${PLAT})
else
  include ${TSP_PLAT_MAKEFILE}
endif