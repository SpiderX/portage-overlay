# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/directxman12/should_be.git"

inherit distutils-r1 git-r3

DESCRIPTION="A Python Assertions Helper"
HOMEPAGE="https://github.com/directxman12/should_be"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/forbiddenfruit[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
