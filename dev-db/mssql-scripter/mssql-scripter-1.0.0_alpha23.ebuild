# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

MY_PV="${PV//_alpha/a}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="CLI for scripting SQL Server Databases"
HOMEPAGE="https://github.com/microsoft/mssql-scripter"
SRC_URI="https://github.com/microsoft/${PN}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/future[${PYTHON_USEDEP}]
	dev-util/lttng-ust:0="

S="${WORKDIR}/${MY_P}"

QA_PREBUILT="usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Security.Cryptography.Native.OpenSsl.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Net.Http.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/MicrosoftSqlToolsServiceLayer
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libhostfxr.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Net.Security.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/MicrosoftSqlToolsCredentials
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libhostpolicy.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/SqlToolsResourceProviderService
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.IO.Compression.Native.so
	/usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/SqlSerializationService"

src_unpack() {
	default

	mkdir "${S}"/mssqlscripter/mssqltoolsservice/bin || die "mkdir failed"
	pushd "${S}"/mssqlscripter/mssqltoolsservice/bin || die "pushd failed"
	unpack ../../../sqltoolsservice/manylinux1/Microsoft.SqlTools.ServiceLayer-linux-x64-netcoreapp2.1.tar.gz
	popd || die "popd failed"
}

python_prepare_all() {
	# Don't install bat
	sed -i "/mssql-scripter.bat/d" setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_test() {
	pushd mssqlscripter || die "pushd mssqlscripter failed"
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
	pushd jsonrpc || die "pushd jsonrpc failed"
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
	popd || die "popd failed"
}
