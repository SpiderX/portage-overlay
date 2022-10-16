# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Super fast SSH2 protocol library, Python bindings for libssh2"
HOMEPAGE="https://github.com/ParallelSSH/ssh2-python"
SRC_URI="https://github.com/ParallelSSH/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-libs/libssh2
	dev-libs/openssl:0=
	sys-libs/zlib:0="
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_configure_all() {
	export SYSTEM_LIBSSH2=1
}
