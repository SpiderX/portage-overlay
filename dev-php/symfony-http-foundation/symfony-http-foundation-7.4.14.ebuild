# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/HttpFoundation"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Defines an object-oriented layer for the HTTP specification"
HOMEPAGE="https://github.com/symfony/http-foundation"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6"

RDEPEND="dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-db/redis
		dev-php/doctrine-dbal
		dev-php/pecl-memcached
		dev-php/predis
		dev-php/symfony-clock
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		dev-php/symfony-http-kernel
		dev-php/symfony-mime
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-7
		dev-php/symfony-rate-limiter
		net-misc/curl )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-7.4.14-tests-common.inc.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	sed -i 's/ ignoreUndefinedTriggers="true"//' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	use ipv6 || edo rm Tests/{IpUtilsTest,RequestTest}.php
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	REDIS_HOST=127.0.0.1 ephpunit
	edo kill "$(<"${T}/redis.pid")"
}
