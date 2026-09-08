# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="mikehaertl/shellcommand"

inherit composer

DESCRIPTION="Simple object oriented interface to execute shell commands in PHP"
HOMEPAGE="https://github.com/mikehaertl/php-shellcommand"
SRC_URI="https://github.com/mikehaertl/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit
