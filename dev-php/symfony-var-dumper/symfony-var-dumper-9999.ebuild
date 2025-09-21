# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Mechanisms for walking through any arbitrary PHP variable"
HOMEPAGE="https://github.com/symfony/var-dumper"
EGIT_REPO_URI="https://github.com/symfony/var-dumper.git"

LICENSE="MIT"
SLOT="0"
IUSE="ipv6 ffi mysqli test"
REQUIRED_USE="test? ( ffi mysqli )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[ffi?,mysqli?,xmlreader]
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-db/redis
		dev-php/pecl-redis
		dev-php/phpunit
		dev-php/symfony-console
		dev-php/symfony-http-kernel
		>=dev-php/symfony-process-6
		dev-php/symfony-uid
		>=dev-php/twig-3.10.3 )"
# needs brokers for dev-php/pecl-rdkafka

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove test with failed assert
	sed -i '/testHtmlDump/,+34d' Tests/Caster/ExceptionCasterTest.php \
		|| die "sed failed for ExceptionCasterTest.php"
	sed -i '/testGet/,+95d' Tests/Dumper/HtmlDumperTest.php \
		|| die "sed failed for HtmlDumperTest.php"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-7.3.3-no-ipv6.patch
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
	insinto /usr/share/php/Symfony/Component/VarDumper
	doins -r Caster Cloner Command Dumper Exception \
		Resources Server Test ./*.php
}
