# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Parameterized testing with any Python test framework"
HOMEPAGE="https://github.com/wolever/parameterized"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*test.*' -delete || die "test removing failed"
}
