# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="A simple Python wheel builder for simple projects"
HOMEPAGE="https://github.com/repo-helper/whey"
EGIT_REPO_URI="https://github.com/repo-helper/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/consolekit[${PYTHON_USEDEP}]
	dev-python/dist-meta[${PYTHON_USEDEP}]
	dev-python/dom-toml[${PYTHON_USEDEP}]
	dev-python/domdf-python-tools[${PYTHON_USEDEP}]
	dev-python/handy-archives[${PYTHON_USEDEP}]
	dev-python/natsort[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyproject-parser[${PYTHON_USEDEP}]
	dev-python/shippinglabel[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-requirements-txt[${PYTHON_USEDEP}]
	test? ( dev-python/coincidence[${PYTHON_USEDEP}]
		dev-python/editables[${PYTHON_USEDEP}]
		dev-python/pyproject-examples[${PYTHON_USEDEP}]
		dev-python/re-assert[${PYTHON_USEDEP}]
		dev-python/whey-conda[${PYTHON_USEDEP}]
		dev-python/whey-pth[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with editable" dev-python/editables
	optfeature "integration with readme"  dev-python/docutils dev-python/editables pyproject-parser
}
