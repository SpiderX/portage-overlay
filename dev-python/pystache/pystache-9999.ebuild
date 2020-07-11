# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/defunkt/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Mustache templating system for Python"
HOMEPAGE="https://github.com/defunkt/pystache"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # fails

distutils_enable_tests nose

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
