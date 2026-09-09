# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/VarDumper"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="ffi?,mysqli?,xmlreader?"

inherit composer

DESCRIPTION="Mechanisms for walking through any arbitrary PHP variable"
HOMEPAGE="https://github.com/symfony/var-dumper"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ipv6 ffi mysqli xmlreader"
REQUIRED_USE="test? ( ffi mysqli xmlreader )"

RDEPEND="dev-php/symfony-console
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-db/redis
		dev-php/doctrine-deprecations
		dev-php/pecl-redis
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-7
		dev-php/symfony-uid
		>=dev-php/twig-3.10.3 )"
# needs brokers for dev-php/pecl-rdkafka

PATCHES=( "${FILESDIR}/${PN}"-7.4.17-bin.patch )

DOCS=( {CHANGELOG,README}.md )

# disable path-layout-sensitive tests
EPHPUNIT_EXCLUDE_FILTER='test(GEt|HtmlDump)'
composer_enable_tests phpunit

src_test() {
	use ipv6 || COMPOSER_TEST_PATCHES+=( "${FILESDIR}/${PN}"-7.4.17-tests-no-ipv6.patch )
	composer_prepare_tests
	sed -i 's/ ignoreUndefinedTriggers="true"//' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF || die "redis-server failed"
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	REDIS_HOST=127.0.0.1 ephpunit
	edo kill "$(<"${T}/redis.pid")"
}

src_install() {
	composer_src_install

	exeinto /usr/share/php/"${COMPOSER_INSTALL_PATH}"/Resources/bin
	doexe Resources/bin/var-dump-server
	dosym ../share/php/"${COMPOSER_INSTALL_PATH}"/Resources/bin/var-dump-server \
		/usr/bin/var-dump-server
}
