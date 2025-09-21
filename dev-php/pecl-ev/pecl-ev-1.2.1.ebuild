# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="ev"
USE_PHP="php8-2 php8-3 php8-4"

inherit php-ext-pecl-r3

DESCRIPTION="PECL extension providing interface to libev library"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libev:="
RDEPEND="${DEPEND}"
