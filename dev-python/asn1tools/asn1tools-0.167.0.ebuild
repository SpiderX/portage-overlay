# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="ASN.1 parsing, encoding and decoding"
HOMEPAGE="https://github.com/eerimoq/asn1tools"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/bitstruct[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/diskcache[${PYTHON_USEDEP}]
		dev-python/prompt-toolkit[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# https://github.com/eerimoq/asn1tools/issues/191
	tests/test_codecs_consistency.py::Asn1ToolsCodecsConsistencyTest::test_c_source
	tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_c_source_oer
	tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_c_source_uper
	tests/test_command_line.py::Asn1ToolsCommandLineTest::test_command_line_generate_rust_source_uper
	tests/test_compile.py::Asn1ToolsCompileTest::test_cache
	tests/test_compile.py::Asn1ToolsCompileTest::test_missing_parameterized_value
	tests/test_oer.py::Asn1ToolsOerTest::test_c_source
	tests/test_parse.py::Asn1ToolsParseTest::test_parse_parameterization
)

pkg_postinst() {
	optfeature "support shell" dev-python/prompt-toolkit
	optfeature "support cache" dev-python/diskcache
}
