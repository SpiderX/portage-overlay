# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/dabeaz/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Coroutine-based library for concurrent Python systems programming"
HOMEPAGE="https://github.com/dabeaz/curio"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest

python_prepare_all() {
	# Remove test requires network
	rm tests/test_network.py || die "rm failed"

	distutils-r1_python_prepare_all
}
