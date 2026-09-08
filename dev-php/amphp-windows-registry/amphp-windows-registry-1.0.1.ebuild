# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/WindowsRegistry"

inherit composer

DESCRIPTION="Windows Registry Reader"
HOMEPAGE="https://github.com/amphp/windows-registry"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-php/amphp-byte-stream
	dev-php/amphp-process"
