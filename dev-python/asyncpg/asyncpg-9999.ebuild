# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="A fast PostgreSQL Database Client Library for Python/asyncio"
HOMEPAGE="https://github.com/MagicStack/asyncpg"
EGIT_REPO_URI="https://github.com/MagicStack/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="kerberos"

RDEPEND="kerberos? ( dev-python/gssapi[${PYTHON_USEDEP}] )"
BDEPEND="test? ( dev-db/postgresql[kerberos?,server(+),ssl]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
		kerberos? ( app-crypt/mit-krb5
			dev-python/k5test[${PYTHON_USEDEP}] ) )"

distutils_enable_tests pytest

python_prepare_all() {
	# bug #926720
	edo cat <<-EOF >> setup.cfg
	[build_ext]
	debug=False
	cython_always=True
	cython_annotate=False
	cython_directives=
	EOF

	# respect CFLAGS
	sed -i "/^CFLAGS/s|'-O2'||" setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_configure_all() {
	use debug && export ASYNCPG_DEBUG=1
	use kerberos || EPYTEST_DESELECT+=( tests/test_connect.py::TestGssAuthentication )
}

python_test() {
	edo cd "${T}" # postgres files are here
	epytest "${S}"/tests
	USE_UVLOOP=1 epytest "${S}"/tests
}
