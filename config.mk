ifneq ($(V),1)
Q := @
endif

PREFIX           ?= /usr/local
BINPREFIX        := $(DESTDIR)$(PREFIX)/bin
MANPREFIX        := $(DESTDIR)$(PREFIX)/share/man
EXAMPLEPREFIX    := $(DESTDIR)$(PREFIX)/share/vimb/example
DOTDESKTOPPREFIX := $(DESTDIR)$(PREFIX)/share/applications
LIBDIR           := $(DESTDIR)$(PREFIX)/lib/vimb
RUNPREFIX        := $(PREFIX)
EXTENSIONDIR     ?= $(RUNPREFIX)/lib/vimb
OS               := $(shell uname -s)

# define some directories
SRCDIR  = src
DOCDIR  = doc

# used libs
LIBS = gtk4 'webkit2gtk-5.0 >= 2.20.0' libsoup-3.0

# setup general used CFLAGS
CFLAGS   += -std=c11 -pipe -Wextra -Wall -fPIC
CPPFLAGS += -DEXTENSIONDIR=\"${EXTENSIONDIR}\"
CPPFLAGS += -DPROJECT=\"vimb\" -DPROJECT_UCFIRST=\"Vimb\"
CPPFLAGS += -DGSEAL_ENABLE
CPPFLAGS += -DGDK_DISABLE_DEPRECATED

ifeq "$(findstring $(OS),FreeBSD DragonFly)" ""
CPPFLAGS += -D_XOPEN_SOURCE=500
CPPFLAGS += -D__BSD_VISIBLE
endif

# flags used to build webextension
EXTTARGET   = webext_main.so
EXTCFLAGS   = ${CFLAGS} $(shell pkg-config --cflags webkit2gtk-web-extension-5.0)
EXTCPPFLAGS = $(CPPFLAGS)
EXTLDFLAGS  = ${LDFLAGS} $(shell pkg-config --libs webkit2gtk-web-extension-5.0) -shared

# flags used for the main application
CFLAGS     += $(shell pkg-config --cflags $(LIBS))
LDFLAGS    += $(shell pkg-config --libs $(LIBS))
LDFLAGS    += -v
