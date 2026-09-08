# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Seld/SignalHandler"
PHP_REQ_USE="pcntl?"

inherit composer git-r3

DESCRIPTION="Simple unix signal handler"
HOMEPAGE="https://github.com/Seldaek/signal-handler"
EGIT_REPO_URI="https://github.com/Seldaek/signal-handler.git"

LICENSE="MIT"
SLOT="0"
IUSE="pcntl"
REQUIRED_USE="test? ( pcntl )"

RDEPEND="dev-php/psr-log"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
# exclude tests needs PHP < 8 or Windows
EPHPUNIT_EXCLUDE_FILTER='(NoAutoGCOnPHP7|OnWindows)'
composer_enable_tests phpunit
