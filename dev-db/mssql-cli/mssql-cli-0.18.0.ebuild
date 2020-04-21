# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..7} )

inherit distutils-r1

DESCRIPTION="CLI for SQL Server Database"
HOMEPAGE="https://github.com/dbcli/mssql-cli"
SRC_URI="https://github.com/dbcli/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test" # fails
RDEPEND=">=dev-python/applicationinsights-0.11.1[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cli_helpers[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/humanize[${PYTHON_USEDEP}]
	dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]
	virtual/krb5"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}] )"

QA_PREBUILT="usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/System.Native.so
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/System.Security.Cryptography.Native.OpenSsl.so
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/System.Net.Http.Native.so
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/MicrosoftSqlToolsServiceLayer
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/libhostfxr.so
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/System.Net.Security.Native.so
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/MicrosoftSqlToolsCredentials
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/libhostpolicy.so
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/SqlToolsResourceProviderService
	usr/lib64/python3.6/site-packages/mssqlcli/mssqltoolsservice/bin/System.IO.Compression.Native.so"

src_unpack() {
	default

	mkdir "${S}"/mssqlcli/mssqltoolsservice/bin || die "mkdir failed"
	pushd "${S}"/mssqlcli/mssqltoolsservice/bin || die "pushd failed"
	unpack ../../../sqltoolsservice/manylinux1/Microsoft.SqlTools.ServiceLayer-rhel-x64-netcoreapp2.2.tar.gz
	popd || die "popd failed"
}

src_prepare() {
	default

	# Remove non linux files
	rm -r mssqlcli/mssqltoolsservice/bin/refs || die "rm failed for refs"
	rm mssqlcli/mssqltoolsservice/bin/*.{dll,pdb,a} || die "rm failed for dll"
	rm mssqlcli/mssqltoolsservice/bin/libcoreclrtraceptprovider.so || die "rm failed for libcoreclrtraceptprovider.so"

	# Relax requirements
	sed -i  -e '/prompt_toolkit/s/ , < 2.1.0//' \
		-e '/sqlparse/s/,<0.3.0//' \
		-e '/cli_helpers/s/, < 1.0.0//' \
		-e '/mssql-cli.bat/d' setup.py \
		|| die "sed failed for setup.py"
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
