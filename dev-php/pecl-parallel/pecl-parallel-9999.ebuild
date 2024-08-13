# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="parallel"
PHP_EXT_NEEDED_USE="threads"
PHP_EXT_ECONF_ARGS="--enable-parallel"
PHP_EXT_S="${WORKDIR}/${P}"
USE_PHP="php8-1 php8-2 php8-3"
EGIT_REPO_URI="https://github.com/krakjoe/parallel.git"

inherit git-r3 php-ext-pecl-r3

DESCRIPTION="A succint parallel concurrency API for PHP"
SRC_URI=""
S="${PHP_EXT_S}"

LICENSE="PHP-3.01"
SLOT="8"
