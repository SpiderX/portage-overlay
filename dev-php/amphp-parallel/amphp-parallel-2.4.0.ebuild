# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Parallel"

inherit composer

DESCRIPTION="An advanced parallelization library for PHP"
HOMEPAGE="https://github.com/amphp/parallel"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parser
	dev-php/amphp-pipeline
	dev-php/amphp-process
	dev-php/amphp-serialization
	dev-php/amphp-socket
	dev-php/amphp-sync
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/pecl-parallel )"

# distro-installed autoload.php paths for process and thread workers
PATCHES=( "${FILESDIR}/${PN}"-2.4.0-process-autoload.patch
	"${FILESDIR}/${PN}"-2.4.0-thread-autoload.patch )

COMPOSER_TEST_FILES=( examples )
COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.4.0-tests-FunctionsTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-phpunit.xml.patch )
composer_enable_tests phpunit
