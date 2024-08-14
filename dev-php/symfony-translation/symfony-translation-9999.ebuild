# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/translation.git"

inherit git-r3

DESCRIPTION="Symfony Translation Component"
HOMEPAGE="https://github.com/symfony/translation"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-translation-contracts"
BDEPEND="test? ( dev-php/nikic-php-parser
		dev-php/phpunit
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		>=dev-php/symfony-finder-6.4.8
		dev-php/symfony-http-client-contracts
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-routing
		dev-php/symfony-yaml )"

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
	insinto /usr/share/php/Symfony/Component/Translation
	doins -r Catalogue Command DataCollector DependencyInjection \
		Dumper Exception Extractor Formatter Loader Provider \
		Reader Resources Test Util Writer ./*.php
}
