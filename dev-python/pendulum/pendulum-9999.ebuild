# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12,13} )

inherit cargo distutils-r1 git-r3

DESCRIPTION="Python datetimes made easy"
HOMEPAGE="https://github.com/python-pendulum/pendulum"
EGIT_REPO_URI="https://github.com/python-pendulum/${PN}.git"

LICENSE="Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/tzdata[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/time-machine[${PYTHON_USEDEP}] )"

QA_FLAGS_IGNORED="usr/lib/python3.*/site-packages/pendulum/_pendulum.cpython-.*-x86_64-linux-gnu.so"

EPYTEST_PLUGINS=( pytest-benchmark )
distutils_enable_tests pytest

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
