#!/usr/bin/bash
# Install build dependencies and then build.

set -xeuo pipefail

dn=$(dirname $0)
. ${dn}/libbuild.sh

${dn}/installdeps.sh

# create an unprivileged user for testing
if ! getent passwd testuser; then
  adduser testuser
fi

# make it clear what rustc version we're compiling with (this is grepped in CI)
rustc --version

export LSAN_OPTIONS=verbosity=1:log_threads=1
# And now the build
build --enable-installed-tests --enable-gtk-doc ${CONFIGOPTS:-}
