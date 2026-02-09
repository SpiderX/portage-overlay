# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Sphinx extension to generate APIs docs from OpenAPI"
HOMEPAGE="https://github.com/sphinx-contrib/openapi"
EGIT_REPO_URI="https://github.com/sphinx-contrib/${PN}.git"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-python/deepmerge[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/picobox[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx-mdinclude[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-httpdomain[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
