# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_PN="${PN}-python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python implementation of the package url spec"
HOMEPAGE="https://github.com/package-url/packageurl-python"
SRC_URI="https://github.com/package-url/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
