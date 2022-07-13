include config.mk

.DEFAULT_GOAL := help

.SILENT: help
.PHONY: help # print help
help:
	grep '^.PHONY: .* #' $(firstword $(MAKEFILE_LIST)) |\
	sed 's/\.PHONY: \(.*\) # \(.*\)/\1 # \2/' |\
	awk 'BEGIN {FS = "#"}; {printf "%-30s%s\n", $$1, $$2}'

.SILENT: build
.PHONY: build # @combo [clean deps compile]
build: clean deps compile

.SILENT: deps
.PHONY: deps # install required dependencies
deps:
	$(PKGC) $(DEPS)

.PHONY: compile # compile dmenu
compile:
	rm -f $(DMENU_PREFIX)/config.h
	make -C $(DMENU_PREFIX)
	sudo make -C $(DMENU_PREFIX) install
	sudo make -C $(DMENU_PREFIX) clean
	rm -f $(DMENU_PREFIX)/config.h

.PHONY: clean # uninstall dmenu
clean:
	sudo make -C $(DMENU_PREFIX) uninstall
