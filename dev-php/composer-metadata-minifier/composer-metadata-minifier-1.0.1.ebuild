# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/MetadataMinifier"

inherit composer

DESCRIPTION="Small utility library that handles metadata minification and expansion"
HOMEPAGE="https://github.com/composer/metadata-minifier"
SRC_URI="https://github.com/composer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit
