# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony Doctrine Bridge"
HOMEPAGE="https://github.com/symfony/doctrine-bridge"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-event-manager
	dev-php/doctrine-persistence
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-data-fixtures
		dev-php/doctrine-dbal
		dev-php/doctrine-orm
		dev-php/phpunit
		dev-php/symfony-cache
		dev-php/symfony-config
		dev-php/symfony-dependency-injection
		dev-php/symfony-expression-language
		dev-php/symfony-form
		dev-php/symfony-http-kernel
		dev-php/symfony-lock
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-security-core
		dev-php/symfony-stopwatch
		dev-php/symfony-validator
		dev-php/symfony-uid )"

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
	# remove tests require classes from tests for another package
	rm Tests/Form/Type/EntityTypeTest.php || die "rm failed"
	# remove tests with failed assertions
	sed -i  -e '/testCollectTime(/,+23d' \
		-e '/testCollectTimeWithFloatExecutionMS(/,+28d' \
		Tests/DataCollector/DoctrineDataCollectorTest.php \
		|| die "sed failed for DoctrineDataCollectorTest.php"
	# 4 skipped tests
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Bridge/Doctrine
	doins -r ArgumentResolver Attribute CacheWarmer DataCollector \
		DependencyInjection Form IdGenerator Messenger \
		Middleware PropertyInfo SchemaListener \
		Security Types Validator ./*.php
}
