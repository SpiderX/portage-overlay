# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Straightforward CLI parsing and dispatching microframework"
HOMEPAGE="https://github.com/mahmoud/face"
EGIT_REPO_URI="https://github.com/mahmoud/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/boltons[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "test" -exec rm -rv {} + || die "tests removing failed"
}
