# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Serialize and deserialize Python objects to and from JSON and XML"
HOMEPAGE="https://github.com/madpah/serializable"
SRC_URI="https://github.com/madpah/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/defusedxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( app-text/xmldiff )"

distutils_enable_tests unittest
