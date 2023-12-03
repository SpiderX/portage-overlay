# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/halfak/${PN}.git"
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 git-r3

DESCRIPTION="A simple utility for merging python dictionaries"
HOMEPAGE="https://github.com/halfak/deep_merge"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # fails

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
