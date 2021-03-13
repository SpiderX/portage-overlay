# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/tomchristie/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Simple immutable types for python"
HOMEPAGE="https://github.com/tomchristie/itypes"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest

python_test() {
	py.test -v tests.py || die "tests failed with ${EPYTHON}"
}
