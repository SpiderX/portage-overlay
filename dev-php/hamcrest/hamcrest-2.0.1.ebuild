# Copyright 1999-2024 Gentoo Authors
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
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-2.0.1-tests.patch )

DOCS=( CHANGES.txt README.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		hamcrest/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove notification of ricky tests
	sed -i  -e '/stopOnFailure/s|>||' \
		-e '/stopOnFailure/a\\t beStrictAboutTestsThatDoNotTestAnything="false">' \
		tests/phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	# replace deprecated method, remove tests
	sed -i  -e "/assertInternalType/s|InternalType('array', |IsArray(|" \
		-e '/testCheckAllAreMatchersAcceptsMatchers/,+7d' \
		-e '/testCheckAllAreMatchersFailsForPrimitive/,+7d' \
		tests/Hamcrest/UtilTest.php || die "sed failed for UtilTest.php"
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
}

src_test() {
	phpunit -c tests/phpunit.xml.dist --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Hamcrest
	doins -r hamcrest/.
}
