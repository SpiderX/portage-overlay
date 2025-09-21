# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony PHPUnit Bridge"
HOMEPAGE="https://github.com/symfony/phpunit-bridge"
EGIT_REPO_URI="https://github.com/symfony/phpunit-bridge.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit
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
