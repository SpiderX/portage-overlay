# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Pipeline"

inherit composer

DESCRIPTION="Concurrent iterators and pipeline operations"
HOMEPAGE="https://github.com/amphp/pipeline"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/amphp-phpunit-util )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-1.2.5-tests-ConcatTest.patch
	"${FILESDIR}/${PN}"-1.2.5-tests-FromIterableTest.patch
	"${FILESDIR}/${PN}"-1.2.5-tests-MergeTest.patch
	"${FILESDIR}/${PN}"-1.2.5-tests-QueueTest.patch
	"${FILESDIR}/${PN}"-1.2.5-tests-TakeWhileTest.patch )
composer_enable_tests phpunit
