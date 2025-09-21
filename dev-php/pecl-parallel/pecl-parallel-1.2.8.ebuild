# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="parallel"
PHP_EXT_NEEDED_USE="threads"
PHP_EXT_ECONF_ARGS="--enable-parallel"
USE_PHP="php8-2 php8-3 php8-4"

inherit php-ext-pecl-r3

DESCRIPTION="A succint parallel concurrency API for PHP"

LICENSE="PHP-3.01"
SLOT="8"
KEYWORDS="~amd64 ~x86"
