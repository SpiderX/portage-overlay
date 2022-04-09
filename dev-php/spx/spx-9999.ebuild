# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="spx"
PHP_EXT_NEEDED_USE="zlib,-threads"
USE_PHP="php7-4 php8-0 php8-1"
EGIT_REPO_URI="https://github.com/NoiseByNorthwest/php-spx.git"

inherit git-r3 php-ext-source-r3

DESCRIPTION="A PHP wrapper fo the scrypt hashing algorithm"
HOMEPAGE="https://github.com/NoiseByNorthwest/php-spx"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND="sys-libs/zlib:0="
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Remove Werror, respect CFLAGS
	sed -i "/CFLAGS/s/-Werror -Wall -O3/$CFLAGS -Wall/" config.m4 \
		|| die "sed failed for config.m4"

	php-ext-source-r3_src_prepare
}
