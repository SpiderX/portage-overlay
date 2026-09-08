# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="League/Flysystem/Local"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="fileinfo"

inherit composer

DESCRIPTION="Sub-split of Flysystem for local file storage"
HOMEPAGE="https://github.com/thephpleague/flysystem-local"
SRC_URI="https://github.com/thephpleague/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no phpunit.xml

PDEPEND="dev-php/league-flysystem" # circular with dev-php/flysystem
RDEPEND="dev-php/league-mime-type-detection"
