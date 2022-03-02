# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/sarnold/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Mustache templating system for Python"
HOMEPAGE="https://github.com/sarnold/pystache"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

distutils_enable_tests nose

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
