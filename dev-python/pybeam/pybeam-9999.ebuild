# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/matwey/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python module to parse Erlang BEAM files"
HOMEPAGE="https://github.com/matwey/pybeam"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/construct[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/six[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest