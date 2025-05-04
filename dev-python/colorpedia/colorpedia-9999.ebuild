# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Command-line tool for looking up colors and palettes"
HOMEPAGE="https://github.com/joowani/colorpedia"
EGIT_REPO_URI="https://github.com/joowani/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/fire[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
