# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Jose/Component"
COMPOSER_INSTALL_SRC="."
COMPOSER_VENDOR="web-token"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"

inherit composer git-r3

DESCRIPTION="PHP JWT Library"
HOMEPAGE="https://github.com/web-token/jwt-library"
EGIT_REPO_URI="https://github.com/web-token/jwt-library.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-php/brick-math
	dev-php/fedora-autoloader
	dev-php/spomky-labs-pki-framework
	dev-php/psr-clock"

DOCS=( README.md )

src_prepare() {
	composer_src_prepare

	edo rm -rf .github
}
