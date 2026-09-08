# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Process"
PHP_REQ_USE="pcntl?"

inherit composer

DESCRIPTION="An async process dispatcher"
HOMEPAGE="https://github.com/amphp/process"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcntl"
REQUIRED_USE="test? ( pcntl )"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-sync
	dev-php/revolt-event-loop"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.1.0-tests-ProcessTest.patch
	"${FILESDIR}/${PN}"-2.1.0-tests-SignalNameTest.patch )
composer_enable_tests phpunit
