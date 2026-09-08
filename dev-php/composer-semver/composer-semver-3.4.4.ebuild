# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/Semver"

inherit composer

DESCRIPTION="Semantic versioning utilities, constraint parsing, and checking"
HOMEPAGE="https://github.com/composer/semver"
SRC_URI="https://github.com/composer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!dev-php/semver"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-MatchAllConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-SemverTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-MatchNoneConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-SubsetsTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-ComparatorTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-MultiConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-VersionParserTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-ConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-IntervalsTest.patch )
composer_enable_tests phpunit
