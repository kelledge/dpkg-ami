# Simple make file to wrap the building of the apt source tree.
#
# This project assumes that it will be built using Debian's
# own set of tools for compiling and packaging. This manually 
# build some of the more useful parts of the apt project, and
# installs them in their expected location for Amazons default
# linux AMI.
#
# There are likley issues with this ... you've been warned.

all: getdeps build

getdeps:
	@echo 'Getting Dependancies:'
	@sudo yum install \
					gcc \
					gcc-c++ \
					autoconf \
					automake \
					flex-devel \
					gettext-devel \
					zlib-devel \
					bzip2-devel \
					xz-devel \
					libselinux-devel \
					ncurses-devel \
					perl-TimeDate \
					perl-IO-String >/dev/null
					

build: getdeps
	# Currently only builds a subset of the available
	# make targets -- only development artifacts are
	# built
	# * shared objects
	# * apt methods (used by external programs such as reprepro)
	# * development headers are 'built' (useful for projects like python-apt)

	@echo 'Building:'
	@cd ./dpkg && autoconf
	./dpkg/./configure --prefix=/usr/local
	make -C ./dpkg/

install: build
	@echo 'Installing:'
	make -C ./dpkg/ install

.PHONY: all clean getdeps
