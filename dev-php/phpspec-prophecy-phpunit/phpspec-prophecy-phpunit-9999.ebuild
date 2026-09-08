# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="phpspec/Prophecy/PhpUnit"

inherit composer git-r3

DESCRIPTION="Integrating Prophecy in PHPUnit test cases"
HOMEPAGE="https://github.com/phpspec/prophecy-phpunit"
EGIT_REPO_URI="https://github.com/phpspec/prophecy-phpunit.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/phpspec-prophecy
	dev-php/phpunit"

composer_enable_tests phpunit
