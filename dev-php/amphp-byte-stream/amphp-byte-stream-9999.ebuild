# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/ByteStream"

inherit composer git-r3

DESCRIPTION="A non-blocking stream abstraction for PHP based on Amp"
HOMEPAGE="https://github.com/amphp/byte-stream"
EGIT_REPO_URI="https://github.com/amphp/byte-stream.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-parser
	dev-php/amphp-pipeline
	dev-php/amphp-serialization
	dev-php/amphp-sync
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-2.1.2-tests.patch )

composer_enable_tests phpunit
