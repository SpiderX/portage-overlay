# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Type annotations and code completion for botocore"
HOMEPAGE="https://github.com/youtype/botocore-stubs"
EGIT_REPO_URI="https://github.com/youtype/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/types-awscrt[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
