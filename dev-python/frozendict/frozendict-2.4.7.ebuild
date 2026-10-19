# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="A simple immutable dictionary for Python"
HOMEPAGE="https://github.com/Marco-Sulla/python-frozendict"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_compile() {
	FROZENDICT_PURE_PY=1 distutils-r1_src_compile
}
