# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="An utility and python library for TCP ports management"
HOMEPAGE="https://github.com/fizyk/port-for"
EGIT_REPO_URI="https://github.com/fizyk/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/urllib3[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
