# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo optfeature pypi

DESCRIPTION="Python client library for MariaDB/MySQL"
HOMEPAGE="https://github.com/mysql/mysql-connector-python"
SRC_URI+="
	https://raw.githubusercontent.com/mysql/mysql-connector-python/refs/heads/trunk/mysql-connector-python/tests/data/ssl/generate.sh
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-db/mysql-connector-c:=
	dev-libs/openssl:=
	dev-python/dnspython[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/mysql[server(+)]
		dev-python/cryptography[${PYTHON_USEDEP}]
		=dev-python/fido2-1.1.2[${PYTHON_USEDEP}]
		dev-python/gssapi[${PYTHON_USEDEP}]
		dev-python/opentelemetry-api[${PYTHON_USEDEP}]
		dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
		dev-python/opentelemetry-exporter-otlp-proto-http[${PYTHON_USEDEP}]
		dev-python/oci[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

src_prepare() {
	default

	if use test ; then
		edo cp "${DISTDIR}"/generate.sh tests/data/ssl
		edo bash tests/data/ssl/generate.sh tests/data/ssl
		# no tests/data/qa/multi_statement
		edo rm tests/qa/test_qa_multi_statement.py
	fi
}

python_test() {
	"${EPYTHON}" unittests.py --with-mysql="/usr" --unix-socket="${T}" --mysql-topdir="${T}" --verbosity 1
}

pkg_postinst() {
	optfeature "interation with kerberos" dev-python/gssapi
	optfeature "interation with oci" dev-python/cryptography dev-python/oci
	optfeature "integration with telemetry" dev-python/opentelemetry-api dev-python/opentelemetry-sdk \
		dev-python/opentelemetry-exporter-otlp-proto-http
	optfeature "integration with webauthn" dev-python/fido2
}
