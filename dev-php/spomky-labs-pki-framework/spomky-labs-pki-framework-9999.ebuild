# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SpomkyLabs/Pki"
COMPOSER_VENDOR="spomky-labs"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"
PHP_REQ_USE="gmp?,ssl?,unicode"

inherit composer git-r3

DESCRIPTION="Public Key Infrastructure"
HOMEPAGE="https://github.com/spomky-labs/pki-framework"
EGIT_REPO_URI="https://github.com/spomky-labs/pki-framework.git"

LICENSE="MIT"
SLOT="0"
IUSE="gmp ssl unicode"
REQUIRED_USE="test? ( gmp ssl )"

RDEPEND="dev-php/brick-math
	dev-php/psr-clock"
BDEPEND="test? ( dev-php/xdebug )"

DOCS=( README.md )

composer_enable_tests phpunit

src_compile() { :; }
