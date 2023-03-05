# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="CLI for SQL Server Database"
HOMEPAGE="https://github.com/dbcli/mssql-cli"
SRC_URI="https://github.com/dbcli/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/applicationinsights-0.11.1[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cli_helpers[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/humanize[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]
	dev-util/lttng-ust:0=
	virtual/krb5"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

QA_PREBUILT="usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/System.Native.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/System.Security.Cryptography.Native.OpenSsl.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/System.Net.Http.Native.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/MicrosoftSqlToolsServiceLayer
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libhostfxr.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/System.Net.Security.Native.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/MicrosoftSqlToolsCredentials
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libhostpolicy.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/SqlToolsResourceProviderService
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/System.IO.Compression.Native.so"
QA_FLAGS_IGNORED="usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libmscordaccore.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libdbgshim.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/System.Globalization.Native.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libsosplugin.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libsos.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libcoreclr.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libcoreclrtraceptprovider.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libclrjit.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/libmscordbi.so
	usr/lib*/python3.*/site-packages/mssqlcli/mssqltoolsservice/bin/createdump"

src_unpack() {
	default

	mkdir "${S}"/mssqlcli/mssqltoolsservice/bin || die "mkdir failed"
	pushd "${S}"/mssqlcli/mssqltoolsservice/bin || die "pushd failed"
	unpack ../../../sqltoolsservice/manylinux1/Microsoft.SqlTools.ServiceLayer-rhel-x64-netcoreapp2.2.tar.gz
	popd || die "popd failed"
}

src_prepare() {
	default

	# Relax requirements, do not install tests
	sed -i  -e "/click/s/,<7.1//" \
		-e "/prompt_toolkit/s/ , < 2.1.0//" \
		-e "/sqlparse/s/,<0.3.0//" \
		-e "/cli_helpers/s/, < 1.0.0//" \
		-e "/mssql-cli.bat/d" \
		-e "/find_packages/s/(/(exclude=['tests','tests.*']/" \
		setup.py || die "sed failed for setup.py"

	# Fix relative import for utility.py
	echo "import os, sys; sys.path.append(os.path.dirname(os.path.realpath(__file__)))" \
		> tests/__init__.py || die "echo failed"
	# Remove test that require network
	rm tests/test_mssqlcliclient.py || die "rm failed for test_mssqlcliclient.py"
	rm tests/test_globalization.py || die "rm failed for test_globalization.py"
	rm tests/test_interactive_mode.py || die "rm failed for test_interactive_mode.py"
	rm tests/test_noninteractive_mode.py || die "rm failed for test_noninteractive_mode.py"
	rm tests/test_special.py || die "rm failed for test_special.py"
	# Remove broken tests
	rm tests/test_smart_completion_multiple_schemata.py || die "rm failed for test_smart_completion_multiple_schemata.py"
	rm tests/test_smart_completion_public_schema_only.py || die "rm failed for test_smart_completion_public_schema_only.py"
	rm tests/test_main.py || die "rm failed for test_main.py"
	# Disable broken tests
	sed -i  -e '/test_distinct_and_order_by_suggestions_with_alias_given/i\    @unittest.skip("disable")' \
		-e '/test_distinct_and_order_by_suggestions_with_aliases/i\    @unittest.skip("disable")' \
		tests/test_sqlcompletion.py || die "sed failed for test_sqlcompletion.py"
}
