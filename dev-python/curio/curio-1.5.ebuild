# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Coroutine-based library for concurrent Python systems programming"
HOMEPAGE="https://github.com/dabeaz/curio"
SRC_URI="https://github.com/dabeaz/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove test requires network
	rm tests/test_network.py || die "rm failed"

	distutils-r1_python_prepare_all
}
