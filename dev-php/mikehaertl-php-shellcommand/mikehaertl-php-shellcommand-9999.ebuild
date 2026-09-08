# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="mikehaertl/shellcommand"

inherit composer git-r3

DESCRIPTION="Simple object oriented interface to execute shell commands in PHP"
HOMEPAGE="https://github.com/mikehaertl/php-shellcommand"
EGIT_REPO_URI="https://github.com/mikehaertl/php-shellcommand.git"

LICENSE="MIT"
SLOT="0"

composer_enable_tests phpunit
