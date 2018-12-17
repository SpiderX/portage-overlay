# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PHP_EXT_NAME="scrypt"
PHP_EXT_PECL_PKG="pecl-scrypt"
PHP_EXT_ECONF_ARGS="--enable-scrypt"
USE_PHP="php5-6 php7-0 php7-1 php7-2"
EGIT_REPO_URI="https://github.com/DomBlack/php-scrypt.git"

inherit git-r3 php-ext-pecl-r3

DESCRIPTION="A PHP wrapper fo the scrypt hashing algorithm"
HOMEPAGE="https://github.com/DomBlack/php-scrypt"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-util/re2c"
