# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to extract credentials from lsass remotely"
HOMEPAGE="https://github.com/login-securite/lsassy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/pypykatz[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# needs server
	tests/test_lsassy.py::TestWriter
	tests/test_lsassy.py::TestWorkflow
	tests/test_lsassy.py::TestExecMethods
	tests/test_lsassy.py::TestDumpMethods
)
