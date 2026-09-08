# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/Semver"

inherit composer git-r3

DESCRIPTION="Semantic versioning utilities, constraint parsing, and checking"
HOMEPAGE="https://github.com/composer/semver"
EGIT_REPO_URI="https://github.com/composer/semver.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="!dev-php/semver"

PATCHES=( "${FILESDIR}/${PN}"-3.4.4-tests-Constraint-MatchAllConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-SemverTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-MatchNoneConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-SubsetsTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-ComparatorTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-MultiConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-VersionParserTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-Constraint-ConstraintTest.patch
	"${FILESDIR}/${PN}"-3.4.4-tests-IntervalsTest.patch )

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit
