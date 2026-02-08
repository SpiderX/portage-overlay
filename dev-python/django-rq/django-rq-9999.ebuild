# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 edo git-r3 optfeature

DESCRIPTION="Django integration for Redis Queue"
HOMEPAGE="https://github.com/rq/django-rq"
EGIT_REPO_URI="https://github.com/rq/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/redis[${PYTHON_USEDEP}]
	dev-python/rq[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-db/redis
		dev-python/sentry-sdk[${PYTHON_USEDEP}]
		dev-python/prometheus-client[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

python_test() {
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	# sysctl -w vm.overcommit_memory=1
	edo django-admin test tests --settings=tests.settings --pythonpath=. -v2
	edo kill "$(<"${T}/redis.pid")"
}

pkg_postinst() {
	optfeature "integration with prometheus" dev-python/prometheus-client
	optfeature "integration with sentry" dev-python/sentry-sdk
}
