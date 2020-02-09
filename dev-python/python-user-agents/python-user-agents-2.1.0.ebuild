# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="A library to identify devices by parsing user agent strings"
HOMEPAGE="https://github.com/selwin/python-user-agents"
SRC_URI="https://github.com/selwin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
