# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/piskvorky/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library to parse, validate and create SPDX documents"
HOMEPAGE="https://github.com/spdx/tools-python"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # https://github.com/spdx/tools-python/issues/844

RDEPEND="dev-python/beartype[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/rdflib[${PYTHON_USEDEP}]
	dev-python/semantic-version[${PYTHON_USEDEP}]
	dev-python/uritools[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# requires pyshacl
	tests/spdx3/validation/json_ld/test_shacl_validation.py
)

python_configure() {
	local -x PYTHONPATH=src:${PYTHONPATH}
	# generate parsetab early, so it gets installed properly
	"${EPYTHON}" <<-EOF || die
		import spdx_tools.spdx.parser.tagvalue.tagvalue_parser as p
		p.Parser()
	EOF
}
