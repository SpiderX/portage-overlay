# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Python CoreSchema"
HOMEPAGE="https://github.com/core-api/python-coreschema"
SRC_URI="https://github.com/core-api/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
