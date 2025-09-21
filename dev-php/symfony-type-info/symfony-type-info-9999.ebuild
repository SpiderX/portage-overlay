# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Extracts PHP types information"
HOMEPAGE="https://github.com/symfony/type-info"
EGIT_REPO_URI="https://github.com/symfony/type-info.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-container
	dev-php/symfony-deprecation-contracts"
BDEPEND="test? ( dev-php/composer
		dev-php/phpstan-phpdoc-parser
		dev-php/phpunit
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
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/TypeInfo
	doins -r Exception Type TypeContext TypeResolver ./*.php
}
