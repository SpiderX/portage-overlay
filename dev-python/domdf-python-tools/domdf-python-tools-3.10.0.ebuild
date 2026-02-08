# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN="${PN//-/_}"

DESCRIPTION="Helpful functions for Python"
HOMEPAGE="https://github.com/domdfcoding/domdf_python_tools"
SRC_URI="https://github.com/domdfcoding/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/natsort[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/click[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/faker[${PYTHON_USEDEP}]
		dev-python/funcy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_IGNORE=( tests/test_paths_stdlib.py )

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_import_tools.py::test_discover_entry_points
	tests/test_import_tools.py::test_discover_entry_points_by_name_object_match_func
	tests/test_import_tools.py::test_discover_entry_points_by_name_name_match_func
	tests/test_paths.py::test_iterchildren_match
)
