# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/microsoft/${PN}.git"

inherit distutils-r1 git-r3

MY_PV="${PV//_alpha/a}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="CLI for scripting SQL Server Databases"
HOMEPAGE="https://github.com/microsoft/mssql-scripter"
SRC_URI="https://github.com/microsoft/sqltoolsservice/releases/download/v3.0.0-release.251/Microsoft.SqlTools.ServiceLayer-rhel-x64-net6.0.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-crypt/mit-krb5
	dev-python/future[${PYTHON_USEDEP}]
	dev-util/lttng-ust:0=
	net-misc/curl"

distutils_enable_tests pytest

QA_PREBUILT="usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/createdump
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libclrjit.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libcoreclr.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libcoreclrtraceptprovider.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libdbgshim.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libhostfxr.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libhostpolicy.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libmscordaccore.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libmscordbi.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libsos.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libsosplugin.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/MicrosoftSqlToolsCredentials
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/MicrosoftSqlToolsServiceLayer
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/SqlSerializationService
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/SqlToolsResourceProviderService
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Native.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Globalization.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.IO.Compression.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Net.Http.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Net.Security.Native.so
	usr/lib*/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/System.Security.Cryptography.Native.OpenSsl.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libSystem.Net.Security.Native.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libSystem.Security.Cryptography.Native.OpenSsl.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/MicrosoftKustoServiceLayer
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libSystem.Native.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libSystem.IO.Compression.Native.so
	usr/lib/python3.*/site-packages/mssqlscripter/mssqltoolsservice/bin/libSystem.Globalization.Native.so"

EPYTEST_DESELECT=(
	# 'Thread' object has no attribute 'isAlive'
	mssqlscripter/jsonrpc/tests/test_jsonrpcclient.py::JsonRpcClientTests::test_normal_shutdown
	mssqlscripter/jsonrpc/tests/test_jsonrpcclient.py::JsonRpcClientTests::test_receive_invalid_response_exception
	mssqlscripter/jsonrpc/tests/test_jsonrpcclient.py::JsonRpcClientTests::test_response_dequeued
	mssqlscripter/jsonrpc/tests/test_jsonrpcclient.py::JsonRpcClientTests::test_response_stream_closed_exception
	mssqlscripter/jsonrpc/tests/test_jsonrpcclient.py::JsonRpcClientTests::test_send_multiple_request
	mssqlscripter/jsonrpc/tests/test_jsonrpcclient.py::JsonRpcClientTests::test_submit_simple_request
)

src_unpack() {
	git-r3_src_unpack

	mkdir "${S}"/mssqlscripter/mssqltoolsservice/bin || die "mkdir failed"
	pushd "${S}"/mssqlscripter/mssqltoolsservice/bin || die "pushd failed"
	unpack Microsoft.SqlTools.ServiceLayer-rhel-x64-net6.0.tar.gz
	popd || die "popd failed"
}

src_prepare() {
	default

	# fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed"
	# don't install bat
	sed -i "/mssql-scripter.bat/d" setup.py || die "sed failed for setup.py"
	# compatibility with recent sqltoolservice
	sed -i '/utf/s|8|16|' mssqlscripter/main.py \
		|| die "sed failed for main.py"
	# don't bloat install with any dir except refs
	find mssqlscripter/mssqltoolsservice/bin -mindepth 1 ! -name refs \
		-type d -not -path '.' -exec rm -rf {} + \
		|| die "find failed"
}
