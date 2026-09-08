# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Egulias/EmailValidator"

inherit composer git-r3

DESCRIPTION="PHP Email address validator"
HOMEPAGE="https://github.com/egulias/EmailValidator"
EGIT_REPO_URI="https://github.com/egulias/EmailValidator.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/doctrine-lexer
	dev-php/symfony-polyfill-intl-idn"

PATCHES=( "${FILESDIR}/${PN}"-4.0.4-tests-DNSCheckValidationTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-EmailLexerTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-EmailParserTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-MessageIDValidationTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-NoRFCWarningsValidationTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-RFCValidationDomainPartTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-RFCValidationTest.patch
	"${FILESDIR}/${PN}"-4.0.4-tests-SpoofCheckValidationTest.patch )

composer_enable_tests phpunit
