# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Super fast SSH2 protocol library, Python bindings for libssh2"
HOMEPAGE="https://github.com/ParallelSSH/ssh2-python"
EGIT_REPO_URI="https://github.com/ParallelSSH/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="net-libs/libssh2
	dev-libs/openssl:0=
	sys-libs/zlib:0="
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/jinja2[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-rerunfailures )
distutils_enable_tests pytest

python_configure_all() {
	export SYSTEM_LIBSSH2=1
}

python_test() {
	local -x PYTHONPATH=../"${PN}"-"${EPYTHON}"/build0/lib.linux-x86_64-cpython-"${EPYTHON/python3_/3}"
	edo rm -rf ssh2
	epytest
}
