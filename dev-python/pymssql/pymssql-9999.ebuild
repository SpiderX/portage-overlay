# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="DB-API interface to Microsoft SQL Server for Python"
HOMEPAGE="https://github.com/pymssql/pymssql"
EGIT_REPO_URI="https://github.com/pymssql/${PN}.git"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="kerberos ssl"

RDEPEND="dev-db/freetds
	kerberos? ( dev-python/gssapi[${PYTHON_USEDEP}]
	dev-python/krb5[${PYTHON_USEDEP}] )
	ssl? ( dev-libs/openssl:= )"
DEPEND="dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	${RDEPEND}"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/gevent[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-{subtests,timeout} )
distutils_enable_tests pytest

python_configure_all() {
	export PYMSSQL_FREETDS="/usr"
	export PYMSSQL_OPENSSL="/usr"
	use kerberos || export LINK_KRB5=NO
	use ssl || export LINK_OPENSSL=NO
}
