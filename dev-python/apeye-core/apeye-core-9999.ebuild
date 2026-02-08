# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Core functionality for the apeye library"
HOMEPAGE="https://github.com/domdfcoding/apeye-core"
EGIT_REPO_URI="https://github.com/domdfcoding/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
