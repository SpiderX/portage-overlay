# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_PKG="CallbackValidator"
COMPOSER_INSTALL_PATH="DaveRandom/CallbackValidator"

inherit composer git-r3

DESCRIPTION="Tools for validating callback signatures in PHP"
HOMEPAGE="https://github.com/DaveRandom/CallbackValidator"
EGIT_REPO_URI="https://github.com/DaveRandom/CallbackValidator.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-20170403-BasePhp71Test.patch
	"${FILESDIR}/${PN}"-20170403-phpunit.xml.patch )

composer_enable_tests phpunit
