# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="An object-oriented API to strings"
HOMEPAGE="https://github.com/symfony/string"
EGIT_REPO_URI="https://github.com/symfony/string.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-intl-grapheme
	dev-php/symfony-polyfill-intl-normalizer
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-emoji
		dev-php/symfony-error-handler
		dev-php/symfony-intl
		dev-php/symfony-translation-contracts )"

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
	insinto /usr/share/php/Symfony/Component/String
	doins -r Exception Inflector Resources Slugger ./*.php
}
