# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for libvalkey"
HOMEPAGE="https://github.com/valkey-io/libvalkey-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # a lot of AssertionError

distutils_enable_tests pytest

python_test() {
	local -x PYTHONPATH=libvalkey
	mv libvalkey/libvalkey.py{i,} || die "mv failed"
	epytest
}
