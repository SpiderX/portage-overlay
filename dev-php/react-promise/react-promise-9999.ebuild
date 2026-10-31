# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="React/Promise"

inherit composer git-r3

DESCRIPTION="A lightweight implementation of CommonJS Promises/A for PHP"
HOMEPAGE="https://github.com/reactphp/promise"
EGIT_REPO_URI="https://github.com/reactphp/promise.git"
SRC_URI="https://github.com/SpiderX/portage-overlay/releases/download/${PN}-3.3.0/${PN}-3.3.0-patches.tar.xz"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${WORKDIR}/${PN}-3.3.0-patches/tests" )

composer_enable_tests phpunit

src_unpack() {
	git-r3_src_unpack
	unpack ${A}
}
