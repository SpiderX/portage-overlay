# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/ByteStream"

inherit composer

DESCRIPTION="A non-blocking stream abstraction for PHP based on Amp"
HOMEPAGE="https://github.com/amphp/byte-stream"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-parser
	dev-php/amphp-pipeline
	dev-php/amphp-serialization
	dev-php/amphp-sync
	dev-php/revolt-event-loop"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.1.2-tests.patch )
composer_enable_tests phpunit
