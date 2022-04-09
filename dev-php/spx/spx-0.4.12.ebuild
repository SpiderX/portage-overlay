# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="php-${PN}"
MY_P="${MY_PN}-${PV}"

PHP_EXT_NAME="spx"
PHP_EXT_NEEDED_USE="zlib,-threads"
PHP_EXT_S="${WORKDIR}/${MY_P}"
USE_PHP="php7-4 php8-0 php8-1"

inherit php-ext-source-r3

DESCRIPTION="A PHP wrapper fo the scrypt hashing algorithm"
HOMEPAGE="https://github.com/NoiseByNorthwest/php-spx"
SRC_URI="https://github.com/NoiseByNorthwest/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/zlib:0="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	# Remove Werror, respect CFLAGS
	sed -i "/CFLAGS/s/-Werror -Wall -O3/$CFLAGS -Wall/" config.m4 \
		|| die "sed failed for config.m4"

	php-ext-source-r3_src_prepare
}
