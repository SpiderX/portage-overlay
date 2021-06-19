# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )
EGIT_REPO_URI="https://github.com/jborean93/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="CredSSP authentication handler for Python Requests"
HOMEPAGE="https://github.com/jborean93/requests-credssp"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pyspnego[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
RESTRICT="test" # no test

distutils_enable_tests pytest
