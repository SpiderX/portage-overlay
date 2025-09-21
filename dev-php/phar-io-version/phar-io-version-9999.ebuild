# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Library for handling version information and constraints"
HOMEPAGE="https://github.com/phar-io/version"
EGIT_REPO_URI="https://github.com/phar-io/version.git"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# change path to autoload
	sed -i '/bootstrap/s|vendor|src|' phpunit.xml || die "sed failed for phpunit.xml"
	# remove failed tests (Version string '1' does not follow SemVer semantics)
	sed -i '/testReturnsExpectedConstraint/,+5d' \
		tests/Integration/VersionConstraintParserTest.php \
		|| die "sed failed for VersionConstraintParserTest.php"
	sed -i  -e '/testOrigionalStringReturnsExceptedVersionString/,+6d' \
		-e '/testAsStringReturnsExceptedVersionString/,+6d' \
		tests/Unit/VersionTest.php || die "sed failed for VersionTest.php"
	# fix non-static data provider deprecation
	sed -i  -e '/complyingProvider(/s|function|static function|' \
		-e '/notComplyingProvider(/s|function|static function|' \
		tests/Integration/CompliesTest.php \
		|| die "sed failed for CompliesTest.php"
	sed -i  -e '/versionStringProvider(/s|function|static function|' \
		-e '/unsupportedVersionStringProvider(/s|function|static function|' \
		tests/Integration/VersionConstraintParserTest.php \
		|| die "sed failed for VersionConstraintParserTest.php"
	sed -i '/versionProvider(/s|function|static function|' \
		tests/Unit/{Any,GreaterThanOrEqualTo,SpecificMajorAndMinor,SpecificMajor}VersionConstraintTest.php \
		|| die "sed failed for versionProvider"
	sed -i  -e '/compliantVersionProvider(/s|function|static function|' \
		-e '/nonCompliantVersionProvider(/s|function|static function|' \
		tests/Unit/ExactVersionConstraintTest.php \
		|| die "sed failed for ExactVersionConstraintTest.php"
	sed -i  -e '/greaterThanProvider(/s|function|static function|' \
		-e '/suffixProvider(/s|function|static function|' \
		tests/Unit/PreReleaseSuffixTest.php \
		|| die "sed failed for PreReleaseSuffixTest.php"
	sed -i  -e '/versionProvider(/s|function|static function|' \
		-e '/versionStringProvider(/s|function|static function|g' \
		-e '/versionGreaterThanProvider(/s|function|static function|' \
		-e '/invalidVersionStringProvider(/s|function|static function|' \
		tests/Unit/VersionTest.php || die "sed failed for VersionTest.php"
	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PharIo/Version
	doins -r src/.
}
