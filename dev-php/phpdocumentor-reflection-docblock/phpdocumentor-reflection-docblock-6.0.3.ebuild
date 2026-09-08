# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="phpDocumentor/Reflection"
PHP_REQ_USE="filter"

inherit composer

DESCRIPTION="phpDocumentor ReflectionDocBlock component"
HOMEPAGE="https://github.com/phpDocumentor/ReflectionDocBlock"
SRC_URI="https://github.com/phpDocumentor/${COMPOSER_PKG/-/}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ReflectionDocBlock-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/doctrine-deprecations
	dev-php/phpdocumentor-reflection-common
	dev-php/phpdocumentor-type-resolver
	dev-php/phpstan-phpdoc-parser
	dev-php/webmozart-assert"
BDEPEND="test? ( dev-php/mockery )"

COMPOSER_TEST_FILES=( docs )
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-6.0.3-tests-AuthorTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-DescriptionFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-DocBlockFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-ExampleTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-MethodFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-MethodParameterTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-ParamFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-PcreExceptionTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-StandardTagFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-TemplateCovariantFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-TemplateFactoryTest.patch
	"${FILESDIR}/${PN}"-6.0.3-tests-TypedTagsTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/DocBlock/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
