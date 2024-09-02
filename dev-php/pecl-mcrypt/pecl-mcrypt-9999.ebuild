# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="mcrypt"
PHP_EXT_ECONF_ARGS="--with-mcrypt"
PHP_EXT_S="${WORKDIR}/${P}"
USE_PHP="php8-1 php8-2 php8-3"
EGIT_REPO_URI="https://github.com/php/pecl-encryption-mcrypt.git"

inherit git-r3 php-ext-pecl-r3

DESCRIPTION="Bindings for the libmcrypt library"
SRC_URI=""
S="${PHP_EXT_S}"

LICENSE="PHP-3.01"
SLOT="0"

DEPEND="dev-libs/libltdl
	dev-libs/libmcrypt"
RDEPEND="${DEPEND}"
