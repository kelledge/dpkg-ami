# Simple make file to wrap the building of the dpkg source tree.
#
# This manually builds the dpkg project, and installs them in 
# their expected location for Amazons default linux AMI.
#
# My Makefile-foo is weak (re-do in cmake?) 
# There are likley issues with this ... you've been warned.

all: getdeps build

getdeps:
	@echo 'Getting Dependancies:'
	@sudo yum --assumeyes install \
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
	@cd ./dpkg/ && ./configure --prefix=/usr/local
	@cd ./dpkg/ && make

install: build
	@echo 'Installing:'
	@cd ./dpkg/ && make install

.PHONY: all clean getdeps
