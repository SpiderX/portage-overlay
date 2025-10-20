# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Parser for pyproject.toml"
HOMEPAGE="https://github.com/repo-helper/pyproject-parser"
SRC_URI="https://github.com/repo-helper/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/apeye-core[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/dom-toml[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/shippinglabel[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/click[${PYTHON_USEDEP}]
		dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/consolekit[${PYTHON_USEDEP}]
		dev-python/pyproject-examples[${PYTHON_USEDEP}]
		dev-python/readme-renderer[${PYTHON_USEDEP}]
		dev-python/sdjson[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with cli" dev-python/click dev-python/consolekit dev-python/sdjson
	optfeature "integration with readme"  dev-python/docutils dev-python/readme-renderer
}
