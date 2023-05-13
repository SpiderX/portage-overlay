# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,10} )
EGIT_REPO_URI="https://github.com/jborean93/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python SPNEGO authentication library"
HOMEPAGE="https://github.com/jborean93/pyspnego"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/gssapi[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
