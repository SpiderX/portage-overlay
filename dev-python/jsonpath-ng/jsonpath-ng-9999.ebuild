# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/h2non/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python JSONPath Next-Generation"
HOMEPAGE="https://github.com/h2non/jsonpath-ng"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/oslotest[${PYTHON_USEDEP}]
		dev-python/testscenarios[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# 'NoneType' object is not iterable
	tests/test_jsonpath_rw_ext.py::Testjsonpath_ng_ext::test_fields_value
)
