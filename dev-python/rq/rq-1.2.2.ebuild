# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="A library for creating and processing background jobs"
HOMEPAGE="https://github.com/rq/rq"
SRC_URI="https://github.com/rq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/redis-py-3.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-db/redis
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/sentry-sdk[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Do not install tests
	sed -i "/packages=find_packages/s/s'/s','tests.*'/" setup.py \
		|| die "sed for setup.py failed"

	distutils-r1_python_prepare_all
}

python_test() {
	/usr/sbin/redis-server --daemonize yes > /dev/null || die "redis start failed"
	./run_tests || die "run_tests failed"
	pgrep redis | xargs kill || die "redis stop failed"
}
