# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Python HCL2"
HOMEPAGE="https://github.com/amplify-education/python-hcl2"
EGIT_REPO_URI="https://github.com/amplify-education/python-hcl2.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="!dev-python/bc-python-hcl2[${PYTHON_USEDEP}]
	dev-python/lark[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]"

DOCS=( {CHANGELOG,README}.md )
