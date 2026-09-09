# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Webmozart/Assert"
PHP_REQ_USE="ctype"

inherit composer

DESCRIPTION="Webmozart Assert"
HOMEPAGE="https://github.com/webmozarts/assert"
SRC_URI="https://github.com/webmozarts/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_FILES=( bin )
composer_enable_tests phpunit
