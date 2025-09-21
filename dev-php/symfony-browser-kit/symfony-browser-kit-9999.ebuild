# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony BrowserKit Component"
HOMEPAGE="https://github.com/symfony/browser-kit"
EGIT_REPO_URI="https://github.com/symfony/browser-kit.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-dom-crawler"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-css-selector
		dev-php/symfony-http-client
		dev-php/symfony-mime
		>=dev-php/symfony-process-6 )"

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
	insinto /usr/share/php/Symfony/Component/BrowserKit
	doins -r Exception Test ./*.php
}
