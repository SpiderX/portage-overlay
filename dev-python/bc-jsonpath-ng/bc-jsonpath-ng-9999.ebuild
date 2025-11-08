# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python JSONPath Next-Generation"
HOMEPAGE="https://github.com/bridgecrewio/jsonpath-ng"
EGIT_REPO_URI="https://github.com/bridgecrewio/jsonpath-ng.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND="dev-python/ply[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/oslotest[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
