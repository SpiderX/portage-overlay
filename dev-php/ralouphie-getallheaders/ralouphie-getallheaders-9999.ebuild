# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Ralouphie/Getallheaders"

inherit composer git-r3

DESCRIPTION="PHP getallheaders polyfill"
HOMEPAGE="https://github.com/ralouphie/getallheaders"
EGIT_REPO_URI="https://github.com/ralouphie/getallheaders.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-3.0.3-tests.patch )

composer_enable_tests phpunit
