# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="eio"
PHP_EXT_ECONF_ARGS="--with-eio"
USE_PHP="php8-1 php8-2 php8-3"

inherit php-ext-pecl-r3

DESCRIPTION="PHP wrapper for libeio library"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
