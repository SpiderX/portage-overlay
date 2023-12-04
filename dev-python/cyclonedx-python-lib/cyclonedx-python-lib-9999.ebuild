# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..12} )
EGIT_REPO_URI="https://github.com/CycloneDX/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python library for generating CycloneDX SBOMs"
HOMEPAGE="https://github.com/CycloneDX/cyclonedx-python-lib"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/license-expression[${PYTHON_USEDEP}]
	dev-python/packageurl[${PYTHON_USEDEP}]
	dev-python/serializable[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]"
BDEPEND="test? ( app-text/xmldiff[${PYTHON_USEDEP}]
		dev-python/ddt[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest

src_prepare() {
	default

	sed -i  -e '/LICENSE/d' \
		-e '/README.md/d' \
		-e '/NOTICE/d' pyproject.toml || die "sed failed"
}
