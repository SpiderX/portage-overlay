# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Jalali implementation of Python's datetime module"
HOMEPAGE="https://github.com/slashmili/jdatetime"
SRC_URI="https://github.com/slashmili/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/jalali-core[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/greenlet[${PYTHON_USEDEP}] )"

DOCS=( CHANGELOG.md README.rst )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# unsupported locale setting
	tests/test_jdatetime.py::TestJDateTime::test_with_fa_locale
)
