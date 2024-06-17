# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
EGIT_REPO_URI="https://github.com/click-contrib/${PN}.git"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Option groups missing in Click"
HOMEPAGE="https://github.com/click-contrib/click-option-group"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
