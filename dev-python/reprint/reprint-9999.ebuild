# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/Yinzo/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Binding variables and refreshing multi-line output in terminal"
HOMEPAGE="https://github.com/Yinzo/reprint"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
