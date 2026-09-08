# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="phpDocumentor/Reflection"
PHP_REQ_USE="tokenizer?"

inherit composer

DESCRIPTION="phpDocumentor TypeResolver component"
HOMEPAGE="https://github.com/phpDocumentor/TypeResolver"
SRC_URI="https://github.com/phpDocumentor/${COMPOSER_PKG/-/}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/TypeResolver-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tokenizer"
REQUIRED_USE="test? ( tokenizer )"

RDEPEND="dev-php/doctrine-deprecations
	dev-php/phpdocumentor-reflection-common
	dev-php/phpstan-phpdoc-parser"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.0.0-ArrayShapeTest.patch
	"${FILESDIR}/${PN}"-2.0.0-ArrayTest.patch
	"${FILESDIR}/${PN}"-2.0.0-CallableTest.patch
	"${FILESDIR}/${PN}"-2.0.0-ClassStringTest.patch
	"${FILESDIR}/${PN}"-2.0.0-ConditionalForParameterTest.patch
	"${FILESDIR}/${PN}"-2.0.0-ConditionalTest.patch
	"${FILESDIR}/${PN}"-2.0.0-EnumStringTest.patch
	"${FILESDIR}/${PN}"-2.0.0-GenericTest.patch
	"${FILESDIR}/${PN}"-2.0.0-IntegerRangeTest.patch
	"${FILESDIR}/${PN}"-2.0.0-InterfaceStringTest.patch
	"${FILESDIR}/${PN}"-2.0.0-IterableTest.patch
	"${FILESDIR}/${PN}"-2.0.0-ListTest.patch
	"${FILESDIR}/${PN}"-2.0.0-NonEmptyArrayTest.patch
	"${FILESDIR}/${PN}"-2.0.0-NonEmptyListTest.patch
	"${FILESDIR}/${PN}"-2.0.0-ObjectShapeTest.patch
	"${FILESDIR}/${PN}"-2.0.0-OffsetAccessTest.patch
	"${FILESDIR}/${PN}"-2.0.0-SelfTest.patch
	"${FILESDIR}/${PN}"-2.0.0-StaticTest.patch
	"${FILESDIR}/${PN}"-2.0.0-TraitStringTest.patch
	"${FILESDIR}/${PN}"-2.0.0-TypeResolverTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir src/TypeResolver
	edo phpab -q -o src/TypeResolver/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
