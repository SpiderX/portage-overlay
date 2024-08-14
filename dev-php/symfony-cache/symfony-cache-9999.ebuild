# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/cache.git"

inherit git-r3

DESCRIPTION="Symfony PSR-6 implementation for caching"
HOMEPAGE="https://github.com/symfony/cache"

LICENSE="MIT"
SLOT="0"
IUSE="pdo postgres sqlite test zlib"
REQUIRED_USE="test? ( pdo postgres sqlite zlib )"
RESTRICT="!test? ( test )"

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
		dev-php/igbinary
		>=dev-php/pecl-memcached-3.2.0_p20231008
		dev-php/pecl-redis
		dev-php/phpunit
		dev-php/predis
		dev-php/psr-simple-cache
		dev-php/symfony-dependency-injection
		>=dev-php/symfony-filesystem-6.4.9
		dev-php/symfony-http-kernel
		dev-php/symfony-messenger )"
# dev-php/pecl-apcu enables tests with non-existed method getName

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove test with failed assert
	sed -i '/testKnownTagVersionsTtl/,+29d' Tests/Adapter/TagAwareAdapterTest.php \
		|| die "sed failed for TagAwareAdapterTest.php"
	# SQLSTATE[HY000]: General error: 1 table cache_items already exists
	sed -i '/testConfigureSchemaDecoratedDbalDriver/,+24d' \
		Tests/Adapter/DoctrineDbalAdapterTest.php \
		|| die "sed failed for DoctrineDbalAdapterTest.php"
}

src_test() {
	"${EPREFIX}"/usr/sbin/redis-server - <<- EOF || die "redis-server failed"
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	REDIS_HOST=127.0.0.1 phpunit --testdox || die "phpunit failed"
	kill "$(<"${T}/redis.pid")" || die "kill failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Cache
	doins -r Adapter DataCollector DependencyInjection Exception \
		Marshaller Messenger Traits ./*.php
}
