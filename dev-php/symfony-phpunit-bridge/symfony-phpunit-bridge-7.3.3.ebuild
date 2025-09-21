# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony PHPUnit Bridge"
HOMEPAGE="https://github.com/symfony/phpunit-bridge"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-error-handler
		dev-php/symfony-polyfill-php81 )"

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
	# https://github.com/symfony/symfony/commit/71a40f4d
	# https://github.com/symfony/symfony/commit/652ba2eb
	eapply "${FILESDIR}/${PN}"-7.3.3-tests.patch
	# skipped 41
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Bridge/PhpUnit
	doins -r Attribute DeprecationErrorHandler Extension Legacy \
		Metadata TextUI bin/simple-phpunit.php ./*.php

	exeinto /usr/share/php/Symfony/Bridge/PhpUnit
	doexe bin/simple-phpunit
	dosym ../share/php/Symfony/Bridge/PhpUnit/simple-phpunit \
		/usr/bin/simple-phpunit
}
