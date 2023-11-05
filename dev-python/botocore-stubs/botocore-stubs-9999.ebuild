# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/youtype/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Type annotations and code completion for botocore"
HOMEPAGE="https://github.com/youtype/botocore-stubs"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/types-awscrt[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
