# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="PharIo/Version"
COMPOSER_VENDOR="${PN%-*}"
COMPOSER_PKG="${PN##*-}"

inherit composer git-r3

DESCRIPTION="Library for handling version information and constraints"
HOMEPAGE="https://github.com/phar-io/version"
EGIT_REPO_URI="https://github.com/phar-io/version.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-php/theseer-Autoload"

PATCHES=( "${FILESDIR}/${PN}"-3.2.1-tests-Integration-CompliesTest.patch
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

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t fedora2 src
}
