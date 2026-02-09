# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Binding variables and refreshing multi-line output in terminal"
HOMEPAGE="https://github.com/Yinzo/reprint"
EGIT_REPO_URI="https://github.com/Yinzo/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
