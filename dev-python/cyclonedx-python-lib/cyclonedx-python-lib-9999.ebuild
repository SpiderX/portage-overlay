# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library for generating CycloneDX SBOMs"
HOMEPAGE="https://github.com/CycloneDX/cyclonedx-python-lib"
EGIT_REPO_URI="https://github.com/CycloneDX/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/packageurl-python[${PYTHON_USEDEP}]
	dev-python/serializable[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/ddt[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
