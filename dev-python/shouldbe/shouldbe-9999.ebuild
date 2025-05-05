# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="A Python Assertions Helper"
HOMEPAGE="https://github.com/directxman12/should_be"
EGIT_REPO_URI="https://github.com/directxman12/should_be.git"

LICENSE="ISC"
SLOT="0"

RDEPEND="dev-python/forbiddenfruit[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
