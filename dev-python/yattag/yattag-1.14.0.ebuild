# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Generate HTML or XML in a pythonic way"
HOMEPAGE="http://www.yattag.org https://github.com/leforestier/yattag"
SRC_URI="https://github.com/leforestier/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_test() {
	"${PYTHON}" -m unittest discover -v test || die "tests failed with ${EPYTHON}"
}
