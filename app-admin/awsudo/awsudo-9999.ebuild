# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/makethunder/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A temporary credentials for AWS roles via sudo-like utility"
HOMEPAGE="https://github.com/makethunder/awsudo"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="app-admin/awscli[${PYTHON_USEDEP}]
	dev-python/boto[${PYTHON_USEDEP}]
	dev-python/retrying[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
