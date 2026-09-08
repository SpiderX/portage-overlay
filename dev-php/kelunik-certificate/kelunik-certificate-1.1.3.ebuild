# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Kelunik/Certificate"
PHP_REQ_USE="ssl"

inherit composer

DESCRIPTION="Access certificate details and transform between different formats"
HOMEPAGE="https://github.com/kelunik/certificate"
SRC_URI="https://github.com/kelunik/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit
