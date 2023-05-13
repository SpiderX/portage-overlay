# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/jml/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library for printing trees on the console"
HOMEPAGE="https://github.com/jml/tree-format"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/testtools[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
