# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/cosmin/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/cosmin/route53-transfer"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/boto[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
