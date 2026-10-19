# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="A simple immutable dictionary for Python"
HOMEPAGE="https://github.com/Marco-Sulla/python-frozendict"
EGIT_REPO_URI="https://github.com/Marco-Sulla/python-frozendict.git"

LICENSE="LGPL-3"
SLOT="0"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_compile() {
	FROZENDICT_PURE_PY=1 distutils-r1_src_compile
}
