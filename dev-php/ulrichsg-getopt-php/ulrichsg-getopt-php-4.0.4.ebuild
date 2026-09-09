# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src"
COMPOSER_INSTALL_PATH="GetOpt"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="unicode"

inherit composer

DESCRIPTION="A PHP library for command-line argument processing"
HOMEPAGE="https://github.com/getopt-php/getopt-php"
SRC_URI="https://github.com/getopt-php/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-4.0.4-test-ArgumentsTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-ArgumentTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-CommandTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-GetoptTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-MagicGettersTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Operands-CommonTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Operands-HelpTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Operands-MultipleTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Operands-StrictTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Operands-ValueTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-OptionParserTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Options-CommonTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Options-HelpTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Options-NonStrictTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Options-ValueTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-TemplateTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-Translator-CommonTest.patch
	"${FILESDIR}/${PN}"-4.0.4-test-ValidationTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo rm -rf .github
}

src_compile() { :; }

src_test() {
	composer_src_test

	edo rm -rf test
}
