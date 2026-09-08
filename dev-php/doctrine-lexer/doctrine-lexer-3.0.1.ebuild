# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine/Common/Lexer"

inherit composer

DESCRIPTION="Doctrine Lexer"
HOMEPAGE="https://github.com/doctrine/lexer"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

composer_enable_tests phpunit
