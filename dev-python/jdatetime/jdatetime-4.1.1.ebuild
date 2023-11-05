# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

MY_PN="python-jalali"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Jalali implementation of Python's datetime module"
HOMEPAGE="https://github.com/slashmili/python-jalali"
SRC_URI="https://github.com/slashmili/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/greenlet[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

DOCS=( CHANGELOG.md README.rst )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# unsupported locale setting
	tests/test_jdatetime.py::TestJDateTime::test_with_fa_locale
)
