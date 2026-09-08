# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/DomCrawler"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony DomCrawler Component"
HOMEPAGE="https://github.com/symfony/dom-crawler"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/masterminds-html5
	dev-php/doctrine-deprecations
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/symfony-css-selector )"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-7.4.17-tests-LegacyHtml5ParserCrawlerTest.patch
	"${FILESDIR}/${PN}"-7.4.17-tests-LegacyParserCrawlerTest.patch
	"${FILESDIR}/${PN}"-7.4.17-tests-TextareaFormFieldTest.patch
	"${FILESDIR}/${PN}"-7.4.17-tests-phpunit.xml.patch )
composer_enable_tests phpunit
