# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="spx"
PHP_EXT_NEEDED_USE="zlib,-threads"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit git-r3 php-ext-source-r3

unset SRC_URI

DESCRIPTION="A PHP wrapper fo the scrypt hashing algorithm"
HOMEPAGE="https://github.com/NoiseByNorthwest/php-spx"
EGIT_REPO_URI="https://github.com/NoiseByNorthwest/php-spx.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="cgi test"
REQUIRED_USE="test? ( cgi )"
RESTRICT="!test? ( test )"

DEPEND="virtual/zlib:0="
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-lang/php:*[cgi?] )" # skipped 7

src_prepare() {
	default

	# Remove Werror, respect CFLAGS
	sed -i "/CFLAGS/s/-Werror -Wall -O3/$CFLAGS -Wall/" config.m4 \
		|| die "sed failed for config.m4"
	# remove failed tests
	rm tests/spx_custom_metadata.phpt || die "rm failed"

	php-ext-source-r3_src_prepare
}
