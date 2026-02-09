# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="SAML Python3 Toolkit"
HOMEPAGE="https://github.com/SAML-Toolkits/python3-saml"
SRC_URI="https://github.com/SAML-Toolkits/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND="dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/xmlsec[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/freezegun[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Internet
	tests/src/OneLogin/saml2_tests/idp_metadata_parser_test.py::OneLogin_Saml2_IdPMetadataParser_Test::testGetMetadataWithHeaders
	tests/src/OneLogin/saml2_tests/idp_metadata_parser_test.py::OneLogin_Saml2_IdPMetadataParser_Test::testParseRemoteWithHeaders
	# AssertionError
	tests/src/OneLogin/saml2_tests/response_test.py::OneLogin_Saml2_Response_Test::testIsInValidEncIssues_2
	tests/src/OneLogin/saml2_tests/response_test.py::OneLogin_Saml2_Response_Test::testValidateTimestamps
	tests/src/OneLogin/saml2_tests/utils_test.py::OneLogin_Saml2_Utils_Test::testAddSign
	)

python_test() {
	local -x PYTHONPATH=src
	epytest
}
