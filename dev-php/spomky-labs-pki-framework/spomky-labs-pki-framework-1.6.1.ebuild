# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SpomkyLabs/Pki"
COMPOSER_VENDOR="spomky-labs"
COMPOSER_PKG="${PN#${COMPOSER_VENDOR}-}"
PHP_REQ_USE="gmp?,ssl?,unicode"

inherit composer

DESCRIPTION="Public Key Infrastructure"
HOMEPAGE="https://github.com/spomky-labs/pki-framework"
SRC_URI="https://github.com/spomky-labs/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gmp ssl unicode"
REQUIRED_USE="test? ( gmp ssl )"

RDEPEND="dev-php/brick-math
	dev-php/psr-clock"
BDEPEND="test? ( dev-php/xdebug )"

DOCS=( README.md )

composer_enable_tests phpunit
