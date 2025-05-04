# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Simple immutable types for python"
HOMEPAGE="https://github.com/tomchristie/itypes"
EGIT_REPO_URI="https://github.com/tomchristie/${PN}.git"

LICENSE="BSD"
SLOT="0"

distutils_enable_tests pytest

python_test() {
	py.test -v tests.py || die "tests failed with ${EPYTHON}"
}
