# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/akesterson/${PN}-python.git"

inherit distutils-r1 git-r3

DESCRIPTION="A python module that will check for package updates"
HOMEPAGE="https://github.com/akesterson/dpath-python"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests nose
