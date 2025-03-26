# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Web framework plugins for apispec"
HOMEPAGE="https://github.com/marshmallow-code/apispec-webframeworks"
EGIT_REPO_URI="https://github.com/marshmallow-code/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/apispec[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/bottle[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
