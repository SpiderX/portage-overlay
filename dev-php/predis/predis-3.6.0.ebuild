# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Predis"

inherit composer

DESCRIPTION="Flexible and feature-complete Redis client for PHP"
HOMEPAGE="https://github.com/predis/predis"
SRC_URI="https://github.com/predis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-http-message"
BDEPEND="test? ( dev-db/redis
		dev-php/relay )"

# ssl tests need cluster, blocking Pub/Sub integration test can hang
# indefinitely due to timing issues
EPHPUNIT_EXCLUDE_FILTER='testPubSubAgainstRedisServerBlocking'
EPHPUNIT_EXCLUDE_GROUP=( cluster realm-stack realm-server sentinel ssl )
COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}-patches/tests" )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF
		daemonize yes
		pidfile "${T}/redis-6379.pid"
		logfile "${T}/redis-6379.log"
		port 6379
		bind 127.0.0.1
	EOF
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF
		daemonize yes
		pidfile "${T}/redis-6479.pid"
		logfile "${T}/redis-6479.log"
		port 6479
		bind 127.0.0.1
	EOF
	REDIS_HOST=127.0.0.1 ephpunit
	edo kill "$(<"${T}/redis-6379.pid")"
	edo kill "$(<"${T}/redis-6479.pid")"
}
