# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A goodie-bag of unix shell and environment tools for py.test"
HOMEPAGE="https://github.com/man-group/pytest-plugins"
EGIT_REPO_URI="https://github.com/man-group/pytest-plugins.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/execnet[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
