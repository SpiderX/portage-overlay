# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Python library for generating CycloneDX SBOMs"
HOMEPAGE="https://github.com/CycloneDX/cyclonedx-python-lib"
SRC_URI="https://github.com/CycloneDX/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/packageurl[${PYTHON_USEDEP}]
	<dev-python/serializable-2[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]"
BDEPEND="test? ( app-text/xmldiff[${PYTHON_USEDEP}]
		dev-python/ddt[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
