# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="uv"
PHP_EXT_ECONF_ARGS="--with-uv"
USE_PHP="php8-1 php8-2 php8-3"

inherit php-ext-pecl-r3

DESCRIPTION="PHP PECL UV extension"

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6"

DEPEND="dev-libs/libuv:0="
RDEPEND="${DEPEND}"

src_prepare() {
	! use ipv6 && eapply "${FILESDIR}/${PN}"-0.3.0-tests.patch
	rm tests/005-uv_listen_cb-not-destroyed.phpt || die "rm failed"
	php-ext-source-r3_src_prepare
}

src_test() {
	SKIP_ONLINE_TESTS=1 php-ext-source-r3_src_test
}
