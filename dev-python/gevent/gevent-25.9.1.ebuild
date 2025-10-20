# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="ssl(+),threads(+)"

inherit distutils-r1 pypi

DESCRIPTION="Coroutine-based concurrency library for Python"
HOMEPAGE="https://github.com/gevent/gevent"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

DEPEND="dev-libs/libev:=
	dev-libs/libuv:=
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	net-dns/c-ares:="
RDEPEND="${DEPEND}
	dev-python/zope-event[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${PN}"-25.9.1-tests.patch )

distutils_enable_tests unittest

python_configure_all() {
	export GEVENTSETUP_EMBED=0
}

python_test() {
	"${EPYTHON}" -m gevent.tests --verbose || die "tests failed with ${EPYTHON}"
}
