# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/GaretJax/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Autorebuild documentation on change"
HOMEPAGE="https://github.com/GaretJax/sphinx-autobuild"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/livereload[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
