# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Coroutine-based library for concurrent Python systems programming"
HOMEPAGE="https://github.com/dabeaz/curio"
EGIT_REPO_URI="https://github.com/dabeaz/${PN}.git"

LICENSE="BSD"
SLOT="0"
RESTRICT="test" # fails

distutils_enable_tests pytest

python_prepare_all() {
	# Remove test requires network
	rm tests/test_network.py || die "rm failed"

	distutils-r1_python_prepare_all
}
