# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/kennethreitz/${PN}.git"

inherit distutils-r1

DESCRIPTION="Text UI colors"
HOMEPAGE="https://github.com/kennethreitz/crayons"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

python_test() {
	"${EPYTHON}" test_crayons.py || die "tests failed with ${EPYTHON}"
}
