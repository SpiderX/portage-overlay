# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/rq/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A library for creating and processing background jobs"
HOMEPAGE="https://github.com/rq/rq"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/redis-py-3.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-db/redis
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/sentry-sdk[${PYTHON_USEDEP}]
		virtual/python-unittest-mock[${PYTHON_USEDEP}] )"

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
