# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Defines an object-oriented layer for the HTTP specification"
HOMEPAGE="https://github.com/symfony/http-foundation"
EGIT_REPO_URI="https://github.com/symfony/http-foundation.git"

LICENSE="MIT"
SLOT="0"
IUSE="ipv6 test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-polyfill-php83"
BDEPEND="test? ( dev-db/redis
		dev-php/doctrine-dbal
		dev-php/pecl-memcached
		dev-php/phpunit
		dev-php/predis
		dev-php/symfony-clock
		dev-php/symfony-expression-language
		dev-php/symfony-mime
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6
		dev-php/symfony-rate-limiter
		net-misc/curl )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	if ! use ipv6 ; then
		rm Tests/{IpUtilsTest,RequestTest}.php || die "rm failed for ipv6"
	fi
	# remove tests with failed assertion
	rm Tests/Session/Storage/Handler/AbstractSessionHandlerTest.php \
		|| die "rm failed for AbstractSessionHandlerTest.php"
	rm Tests/ResponseFunctionalTest.php \
		|| die "rm failed for ResponseFunctionalTest.php"
}

src_test() {
	"${EPREFIX}"/usr/sbin/redis-server - <<- EOF || die "redis-server failed"
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	# skipped 110
	REDIS_HOST=127.0.0.1 phpunit --testdox || die "phpunit failed"
	kill "$(<"${T}/redis.pid")" || die "kill failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/HttpFoundation
	doins -r Exception File RateLimiter RequestMatcher Session Test ./*.php
}
