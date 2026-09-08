# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="lib/Doctrine/Common/Annotations"
COMPOSER_INSTALL_PATH=""
COMPOSER_INSTALL_SRC="lib"
PHP_REQ_USE="tokenizer"

inherit composer

DESCRIPTION="Doctrine Annotations"
HOMEPAGE="https://github.com/doctrine/annotations"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-lexer
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/doctrine-common
		dev-php/symfony-cache )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.0.2-tests-AnnotationReaderTest.patch
	"${FILESDIR}/${PN}"-2.0.2-tests-DocParserTest.patch
	"${FILESDIR}/${PN}"-2.0.2-tests-PhpParserTest.patch
	"${FILESDIR}/${PN}"-2.0.2-tests-PsrCachedReaderTest.patch
	"${FILESDIR}/${PN}"-2.0.2-tests-phpunit.xml.patch )
composer_enable_tests phpunit
