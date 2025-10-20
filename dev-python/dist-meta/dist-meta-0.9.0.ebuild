# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Parse and create Python distribution metadata"
HOMEPAGE="https://github.com/repo-helper/dist-meta"
SRC_URI="https://github.com/repo-helper/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/handy-archives[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/apeye[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/first[${PYTHON_USEDEP}]
		dev-python/pypi-json[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# https://github.com/repo-helper/dist-meta/issues/21
	tests/test_metadata_top_packages.py
)
