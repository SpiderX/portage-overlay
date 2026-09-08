# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Hamcrest"
COMPOSER_INSTALL_SRC="hamcrest"
COMPOSER_PKG="${PN}-php"

inherit composer

DESCRIPTION="PHP Hamcrest implementation"
HOMEPAGE="https://github.com/hamcrest/hamcrest-php"
SRC_URI="https://github.com/${PN}/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit-php-file-iterator )"

DOCS=( CHANGES.txt README.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.0.0-phpunit.xml.patch
	"${FILESDIR}/${PN}"-3.0.0-CombinableMatcherTest.patch
	"${FILESDIR}/${PN}"-3.0.0-FeatureMatcherTest.patch
	"${FILESDIR}/${PN}"-3.0.0-HasXPathTest.patch
	"${FILESDIR}/${PN}"-3.0.0-IsEqualIgnoringWhiteSpaceTest.patch
	"${FILESDIR}/${PN}"-3.0.0-IsInstanceOfTest.patch
	"${FILESDIR}/${PN}"-3.0.0-MatcherAssertTest.patch
	"${FILESDIR}/${PN}"-3.0.0-SetTest.patch
	"${FILESDIR}/${PN}"-3.0.0-StringContainsIgnoringCaseTest.patch
	"${FILESDIR}/${PN}"-3.0.0-StringContainsInOrderTest.patch
	"${FILESDIR}/${PN}"-3.0.0-StringContainsTest.patch
	"${FILESDIR}/${PN}"-3.0.0-StringDescriptionTest.patch
	"${FILESDIR}/${PN}"-3.0.0-StringEndsWithTest.patch
	"${FILESDIR}/${PN}"-3.0.0-StringStartsWithTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o hamcrest/autoload.php -t "${FILESDIR}"/autoload.php.tpl hamcrest
}

src_test() {
	edo composer create-project -q --no-install --prefer-source "${COMPOSER_PN}:${PV}" "${COMPOSER_SRC}"
	edo cp -r "${COMPOSER_SRC}"/tests "${S}"
	composer_test_patch
	edo phpab -q -o tests/autoload.php -t fedora2 tests
	ephpunit -c tests/phpunit.xml.dist
}
