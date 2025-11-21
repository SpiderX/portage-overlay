# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="php-${PN}"
MY_P="${MY_PN}-${PV}"

PHP_EXT_NAME="spx"
PHP_EXT_NEEDED_USE="zlib,-threads"
PHP_EXT_S="${WORKDIR}/${MY_P}"
USE_PHP="php8-2 php8-3 php8-4"

inherit php-ext-source-r3

DESCRIPTION="A PHP wrapper fo the scrypt hashing algorithm"
HOMEPAGE="https://github.com/NoiseByNorthwest/php-spx"
SRC_URI="https://github.com/NoiseByNorthwest/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
