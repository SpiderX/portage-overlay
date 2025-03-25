# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 pypi

DESCRIPTION="Java Property file parser and writer for Python"
HOMEPAGE="https://github.com/Tblue/python-jproperties"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-datadir-ng[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

src_prepare() {
	default
	rm pytest.ini || die "rm failed"
}
