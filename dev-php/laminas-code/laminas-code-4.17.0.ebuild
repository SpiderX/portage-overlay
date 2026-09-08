# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Laminas/Code"
COMPOSER_VENDOR="${PN%%-*}"
COMPOSER_PKG="${PN#*-}"
COMPOSER_PN="${COMPOSER_VENDOR}/${COMPOSER_VENDOR}-${COMPOSER_PKG}"
COMPOSER_SRC="${T}/composer/${COMPOSER_VENDOR}-${COMPOSER_PKG}"
PHP_REQ_USE="phar"

inherit composer

DESCRIPTION="Extensions to the PHP Reflection API"
HOMEPAGE="https://github.com/laminas/laminas-code"
SRC_URI="https://github.com/laminas/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/doctrine-annotations
		dev-php/laminas-stdlib )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-4.17.0-tests-AbstractGeneratorTest.patch
	"${FILESDIR}/${PN}"-4.17.0-tests-AbstractMemberGeneratorTest.patch
	"${FILESDIR}/${PN}"-4.17.0-tests-ClassGeneratorTest.patch
	"${FILESDIR}/${PN}"-4.17.0-tests-ParameterReflectionTest.patch
	"${FILESDIR}/${PN}"-4.17.0-tests-PropertyGeneratorTest.patch )
composer_enable_tests phpunit
