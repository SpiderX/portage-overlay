# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Simple immutable types for python"
HOMEPAGE="https://github.com/tomchristie/itypes"
SRC_URI="https://github.com/tomchristie/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests pytest

python_test() {
	py.test -v tests.py || die "tests failed with ${EPYTHON}"
}
