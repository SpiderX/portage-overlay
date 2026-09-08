# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Masterminds"
PHP_REQ_USE="xml"

inherit composer

DESCRIPTION="An HTML5 parser and serializer for PHP"
HOMEPAGE="https://github.com/Masterminds/html5-php"
SRC_URI="https://github.com/Masterminds/${COMPOSER_PKG}-php/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${COMPOSER_PKG}-php-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.11.0-tests-Html5Test.patch
	"${FILESDIR}/${PN}"-2.11.0-tests-OutputRulesTest.patch
	"${FILESDIR}/${PN}"-2.11.0-tests-TraverserTest.patch )
composer_enable_tests phpunit
