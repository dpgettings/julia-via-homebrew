#!/bin/bash

# Script to install Julia from source on OSX 10.6.4
# Basic instructions provided here:  
#    https://github.com/staticfloat/homebrew-julia

# ########################################
# Step 1 -- Set up initial environment
# ########################################
BREW_PREFIX=$(brew --prefix)   # Most likely "/usr/local"

### Make PATH from scratch
PATH="${BREW_PREFIX}/bin:/usr/bin"   # Order of these two matters
PATH="${PATH}:/bin:/usr/sbin:/sbin:/usr/X11/bin"
PATH="${PATH}:/Developer/usr/bin"   # Location of XCode binaries

### Compiler environment variables
CC="/usr/bin/gcc-4.2"
CXX="/usr/bin/g++-4.2"

### Compiler flags
CFLAGS="-Os -w -pipe -march=core2 -msse4.1 -mmacosx-version-min=10.6"
CXXFLAGS="-Os -w -pipe -march=core2 -msse4.1 -mmacosx-version-min=10.6"
LDFLAGS="-L${BREW_PREFIX}/lib -Wl,-headerpad_max_install_names"
MAKEFLAGS="-j2"

### Paths relevant for building/compilation
CPATH="${BREW_PREFIX}/include"
PKG_CONFIG_LIBDIR="${BREW_PREFIX}/lib/pkgconfig:/usr/lib/pkgconfig"
ACLOCAL_PATH="${BREW_PREFIX}/share/aclocal"

### Homebrew-specific variables
MACOSX_DEPLOYMENT_TARGET="10.6"
HOMEBREW_CC="gcc-4.2"
HOMEBREW_CXX="g++-4.2"
#HOMEBREW_VERBOSE="#"
#HOMEBREW_EDITOR='emacs -nw'


# ############################################
# Step 2 -- Make sure gfortran is installed
# ############################################
### Update homebrew, add homebrew/versions "tap"
brew tap homebrew/versions
brew update

### Install default GCC, making sure to include fortran
brew install --with-fortran gcc

### Other possibilities
#brew reinstall --with-fortran gcc   # Re-install: If Homebrew complains gcc is already installed
#brew install --with-fortran gcc49   # Alternative: install latest version of GCC with gfortran

### Add Fortran compiler environment variables
FC="gfortran"
HOMEBREW_FC="gfortran"


# ########################################################
# Step 3 -- Install Julia formula from staticfloat/julia
# ########################################################
### Install from instructions from: https://github.com/staticfloat/homebrew-julia
brew tap staticfloat/julia
brew install -v --debug --build-debug julia

### If that fails, maybe try this?
#brew reinstall -v --debug --build-debug julia






