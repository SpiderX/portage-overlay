# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/dom-crawler.git"

inherit git-r3

DESCRIPTION="Symfony DomCrawler Component"
HOMEPAGE="https://github.com/symfony/dom-crawler"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/masterminds-html5
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-css-selector )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# replace TestFailure with ThrowableToStringMapper
	sed -i  -e '/use PHPUnit/s|Framework\\\TestFailure|Util\\\ThrowableToStringMapper|' \
		-e '/assertEquals/s|TestFailure::exceptionToString|ThrowableToStringMapper::map|' \
		Tests/Test/Constraint/CrawlerAnySelectorText{Contains,Same}Test.php \
		Tests/Test/Constraint/CrawlerSelector{AttributeValueSame,Exists}Test.php \
		Tests/Test/Constraint/CrawlerSelectorText{Contains,Same}Test.php \
		|| die "sed failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/DomCrawler
	doins -r Field Test ./*.php
}
