# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} python3_13t )

inherit distutils-r1 git-r3

DESCRIPTION="Java Property file parser and writer for Python"
HOMEPAGE="https://github.com/Tblue/python-jproperties"
EGIT_REPO_URI="https://github.com/Tblue/python-jproperties.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest-datadir-ng[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

src_prepare() {
	default
	rm pytest.ini || die "rm failed"
}
