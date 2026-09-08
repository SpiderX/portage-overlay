# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Cache"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="pdo?,postgres?,sqlite?,zlib?"

inherit composer

DESCRIPTION="Symfony PSR-6 implementation for caching"
HOMEPAGE="https://github.com/symfony/cache"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pdo postgres sqlite zlib"
REQUIRED_USE="test? ( pdo postgres sqlite zlib )"

RDEPEND="dev-php/psr-cache
	dev-php/psr-log
	dev-php/symfony-cache-contracts
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-service-contracts
	dev-php/symfony-var-exporter"
BDEPEND="test? ( dev-db/redis
		dev-php/cache-integration-tests
		dev-php/doctrine-dbal
		dev-php/pecl-apcu
		dev-php/pecl-igbinary
		dev-php/pecl-memcached
		dev-php/pecl-redis
		dev-php/predis
		dev-php/psr-simple-cache
		dev-php/symfony-dependency-injection
		>=dev-php/symfony-filesystem-7
		dev-php/symfony-http-kernel
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

# symfony-cache doesn't support predis-3
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-7.4.17-tests-PredisAdapterTest.patch
	"${FILESDIR}/${PN}"-7.4.17-tests-phpunit.xml.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	REDIS_HOST=127.0.0.1 php -d zend.assertions=1 /usr/bin/phpunit --testdox
	edo kill "$(<"${T}/redis.pid")"
}
