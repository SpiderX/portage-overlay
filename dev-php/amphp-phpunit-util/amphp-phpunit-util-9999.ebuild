# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/PHPUnit"

inherit composer git-r3

DESCRIPTION="Helper package to ease testing with PHPUnit"
HOMEPAGE="https://github.com/amphp/phpunit-util"
EGIT_REPO_URI="https://github.com/amphp/phpunit-util.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/amphp-amp
	dev-php/phpunit
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-3.0.0-phpunit12.patch
	"${FILESDIR}/${PN}"-3.0.0-tests.patch )
