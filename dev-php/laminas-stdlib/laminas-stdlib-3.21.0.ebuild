# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Laminas/Stdlib"
COMPOSER_VENDOR="${PN%%-*}"
COMPOSER_PKG="${PN#*-}"
COMPOSER_PN="${COMPOSER_VENDOR}/${COMPOSER_VENDOR}-${COMPOSER_PKG}"
COMPOSER_SRC="${T}/composer/${COMPOSER_VENDOR}-${COMPOSER_PKG}"

inherit composer

DESCRIPTION="SPL extensions, array utilities, error handlers, and more"
HOMEPAGE="https://github.com/laminas/laminas-stdlib"
SRC_URI="https://github.com/laminas/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit
