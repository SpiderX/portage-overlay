# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Easy, clean, reliable Python 2/3 compatibility"
HOMEPAGE="https://github.com/PythonCharmers/python-future"
SRC_URI+=" https://dev.gentoo.org/~sam/distfiles/${CATEGORY}/${PN}/${PN}-0.18.3-tests.patch.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="test? ( $(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]' 'python*') )"

PATCHES=(
	"${FILESDIR}"/${PN}-0.18.3-tests.patch
	"${FILESDIR}"/${PN}-0.18.2-py39.patch
	"${FILESDIR}"/${PN}-0.18.2-py39-fileurl.patch
	"${FILESDIR}"/${PN}-0.18.2-py3.10.patch
)

EPYTEST_DESELECT=(
	tests/test_future/test_builtins.py::BuiltinTest::test_compile
)

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-bootstrap-theme
