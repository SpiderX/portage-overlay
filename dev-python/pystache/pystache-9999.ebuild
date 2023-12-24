# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/PennyDreadfulMTG/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Mustache templating system for Python"
HOMEPAGE="https://github.com/PennyDreadfulMTG/pystache"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/importlib-metadata[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
