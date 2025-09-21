# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="ev"
PHP_EXT_S="${WORKDIR}/${P}"
USE_PHP="php8-2 php8-3 php8-4"

inherit git-r3 php-ext-pecl-r3

DESCRIPTION="PECL extension providing interface to libev library"
EGIT_REPO_URI="https://bitbucket.org/osmanov/pecl-ev.git"
SRC_URI=""
S="${PHP_EXT_S}"

LICENSE="PHP-3.01"
SLOT="0"

DEPEND="dev-libs/libev:="
RDEPEND="${DEPEND}"
