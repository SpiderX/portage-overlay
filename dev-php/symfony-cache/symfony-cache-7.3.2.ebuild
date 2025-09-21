# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony PSR-6 implementation for caching"
HOMEPAGE="https://github.com/symfony/cache"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pdo postgres sqlite test zlib"
REQUIRED_USE="test? ( pdo postgres sqlite zlib )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[pdo?,postgres?,sqlite?,zlib?]
	dev-php/fedora-autoloader
	dev-php/psr-cache
	dev-php/psr-log
	dev-php/symfony-cache-contracts
	dev-php/symfony-service-contracts
	dev-php/symfony-var-exporter"
BDEPEND="test? ( dev-db/redis
		dev-php/cache-integration-tests
		dev-php/composer
		dev-php/doctrine-dbal
		dev-php/pecl-apcu
		dev-php/pecl-igbinary
		dev-php/pecl-memcached
		dev-php/pecl-redis
		dev-php/phpunit
		dev-php/predis
		dev-php/psr-simple-cache
		dev-php/symfony-dependency-injection
		>=dev-php/symfony-filesystem-6
		dev-php/symfony-http-kernel
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	"${EPREFIX}"/usr/sbin/redis-server - <<- EOF || die "redis-server failed"
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	# needs apc.enable_cli=1
	REDIS_HOST=127.0.0.1 phpunit --exclude-group time-sensitive --testdox \
		|| die "phpunit failed"
	kill "$(<"${T}/redis.pid")" || die "kill failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Cache
	doins -r Adapter DataCollector DependencyInjection Exception \
		Marshaller Messenger Traits ./*.php
}
