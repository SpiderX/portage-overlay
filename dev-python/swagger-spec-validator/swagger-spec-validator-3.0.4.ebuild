# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

MY_PN="${PN//-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library that validates Swagger Specs"
HOMEPAGE="https://github.com/Yelp/swagger_spec_validator"
SRC_URI="https://github.com/Yelp/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-3.0.4-import.patch )

distutils_enable_tests pytest
