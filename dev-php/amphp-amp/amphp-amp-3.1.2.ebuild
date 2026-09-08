# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp"
PHP_REQ_USE="pcntl?"

inherit composer

DESCRIPTION="A non-blocking concurrency framework for PHP applications"
HOMEPAGE="https://github.com/amphp/amp"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcntl"
REQUIRED_USE="test? ( pcntl )"

RDEPEND="dev-php/revolt-event-loop"

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-3.1.2-tests.patch )
composer_enable_tests phpunit
