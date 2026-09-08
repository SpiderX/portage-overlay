# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="PharIo/Version"
COMPOSER_VENDOR="${PN%-*}"
COMPOSER_PKG="${PN##*-}"

inherit composer

DESCRIPTION="Library for handling version information and constraints"
HOMEPAGE="https://github.com/phar-io/version"
SRC_URI="https://github.com/phar-io/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.2.1-tests-Integration-CompliesTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Integration-VersionConstraintParserTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-AbstractVersionConstraintTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-AndVersionConstraintGroupTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-AnyVersionConstraintTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-SpecificMajorVersionConstraintTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-SpecificMajorAndMinorVersionConstraintTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-PreReleaseSuffixTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-OrVersionConstraintGroupTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-GreaterThanOrEqualToVersionConstraintTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-ExactVersionConstraintTest.patch
	"${FILESDIR}/${PN}"-3.2.1-tests-Unit-VersionTest.patch )
composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t fedora2 src
}
