# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//phar-io-/}"

DESCRIPTION="Library for handling version information and constraints"
HOMEPAGE="https://github.com/phar-io/version"
SRC_URI="https://github.com/phar-io/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/composer
		dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev phar-io/version:"${PV}" || die "composer failed"
	cp -r "${T}"/vendor/phar-io/version/{phpunit.xml,tests} "${S}" \
		|| die "cp failed"
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
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PharIo/Version
	doins -r src/.
}
