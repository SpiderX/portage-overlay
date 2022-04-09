# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_ECONF_ARGS="--enable-scrypt"
USE_PHP="php7-4 php8-0 php8-1"

inherit php-ext-pecl-r3

DESCRIPTION="A PHP wrapper fo the scrypt hashing algorithm"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-util/re2c"

PATCHES=( "${FILESDIR}"/"${P}"-php8-0.patch )
