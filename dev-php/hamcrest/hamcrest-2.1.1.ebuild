# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN}-php"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PHP Hamcrest implementation"
HOMEPAGE="https://github.com/hamcrest/hamcrest-php"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/phpunit-php-file-iterator )"

DOCS=( CHANGES.txt README.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		hamcrest/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN}/${PN}"-php:"${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN}/${PN}"-php/tests "${S}" \
		|| die "cp failed"
	# remove notification of ricky tests
	sed -i  -e '/stopOnFailure/s|>||' \
		-e '/stopOnFailure/a\\t beStrictAboutTestsThatDoNotTestAnything="false">' \
		tests/phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	# fix abstract class with Test suffix
	mv tests/Hamcrest/AbstractMatcherTest{,X}.php \
		|| die "mv failed for AbstractMatcherTest.php"
	mv tests/Hamcrest/BaseMatcherTest{,X}.php \
		|| die "mv failed for BaseMatcherTest.php"
	sed -i 's/AbstractMatcherTest/AbstractMatcherTestX/' \
		tests/Hamcrest/AbstractMatcherTestX.php \
		tests/Hamcrest/FeatureMatcherTest.php \
		tests/Hamcrest/{Array,Collection/,Core,Number,Text,Type,Xml}/*.php \
		|| die "sed failed for AbstractMatcherTestX"
	sed -i '/class Base/s|Test|TestX|' tests/Hamcrest/BaseMatcherTestX.php \
		|| die "sed failed for BaseMatcherTestX.php"
	sed -i '/class SampleInvokeMatcher/s|$|X|' tests/Hamcrest/InvokedMatcherTest.php \
		|| die "sed failed for InvokedMatcherTest.php"
	phpab -q -o tests/autoload.php -t fedora2 tests || die "phpab failed"
	phpunit -c tests/phpunit.xml.dist --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Hamcrest
	doins -r hamcrest/.
}
