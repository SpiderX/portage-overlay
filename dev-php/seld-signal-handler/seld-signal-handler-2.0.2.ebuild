# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Seld/SignalHandler"
PHP_REQ_USE="pcntl?"

inherit composer

DESCRIPTION="Simple unix signal handler"
HOMEPAGE="https://github.com/Seldaek/signal-handler"
SRC_URI="https://github.com/Seldaek/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcntl"
REQUIRED_USE="test? ( pcntl )"

RDEPEND="dev-php/psr-log"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
# exclude tests needs PHP < 8 or Windows
EPHPUNIT_EXCLUDE_FILTER='(NoAutoGCOnPHP7|OnWindows)'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.0.2-tests.patch )
composer_enable_tests phpunit
