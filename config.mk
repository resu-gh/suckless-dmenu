OS = $(shell uname -s)

DMENU_PREFIX = $(CURDIR)/dmenu

ifeq "$(OS)" "Linux"
	ID = $(shell grep -w 'ID' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
endif

ifdef ID
	ifeq "$(ID)" "void"
		PKGC = sudo xbps-install -y
		DEPS = $(shell cat ./deps/linux/void)
	endif
endif

ifndef PKGC
	$(error unknown package manager command)
endif
ifndef DEPS
	$(error unknown dependencies file)
endif
