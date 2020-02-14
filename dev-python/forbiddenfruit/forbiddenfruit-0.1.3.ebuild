# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Patch python built-in objects"
HOMEPAGE="https://github.com/clarete/forbiddenfruit"
SRC_URI="https://github.com/clarete/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # fails

BDEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}
