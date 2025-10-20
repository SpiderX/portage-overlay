# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Hatchling plugin to read project dependencies from requirements.txt"
HOMEPAGE="https://github.com/repo-helper/hatch-requirements-txt"
SRC_URI="https://github.com/repo-helper/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/packaging[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/domdf-python-tools[${PYTHON_USEDEP}]
		dev-python/pkginfo[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-0.4.1-tests.patch )

distutils_enable_tests pytest
