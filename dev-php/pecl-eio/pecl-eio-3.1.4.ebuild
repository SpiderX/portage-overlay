# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="eio"
PHP_EXT_ECONF_ARGS="--with-eio"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit php-ext-pecl-r3

DESCRIPTION="PHP wrapper for libeio library"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcntl test"
REQUIRED_USE="test? ( pcntl )"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lang/php:*[pcntl?] )" # skipped 2
