# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="memcache"
USE_PHP="php8-2 php8-3 php8-4"

inherit php-ext-pecl-r3

DESCRIPTION="PHP extension for using memcached"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+session test"
RESTRICT="test"
PROPERTIES="test_network"

DEPEND="sys-libs/zlib:="
BDEPEND="test? ( net-misc/memcached )"

src_prepare() {
	sed -i "/domainsocket/s|var/run/memcached|${T}|" \
		tests/connect.inc || die "sed failed"

	php-ext-source-r3_src_prepare
}

src_configure() {
	local PHP_EXT_ECONF_ARGS=(
		--enable-memcache
		--with-zlib-dir="${EPREFIX}/usr"
		"$(use_enable session memcache-session)"
	)
	php-ext-source-r3_src_configure
}

src_test() {
	memcached -d -P "${T}/memcached-s.pid" -s "${T}/memcached.sock" \
		|| die "memcached-s failed"
	memcached -d -P "${T}/memcached-1.pid" -p 11211 -l 127.0.0.1 -U 11211 \
		|| die "memcached-1 failed"
	memcached -d -P "${T}/memcached-2.pid" -p 11212 -l 127.0.0.1 -U 11212 \
		|| die "memcached-2 failed"
	php-ext-pecl-r3_src_test
	kill "$(<"${T}/memcached-s.pid")" || die "memcached-1 kill failed"
	kill "$(<"${T}/memcached-1.pid")" || die "memcached-2 kill failed"
	kill "$(<"${T}/memcached-2.pid")" || die "memcached-s kill failed"
}

src_install() {
	php-ext-pecl-r3_src_install

	php-ext-source-r3_addtoinifiles "memcache.allow_failover" "true"
	php-ext-source-r3_addtoinifiles "memcache.max_failover_attempts" "20"
	php-ext-source-r3_addtoinifiles "memcache.chunk_size" "32768"
	php-ext-source-r3_addtoinifiles "memcache.default_port" "11211"
	php-ext-source-r3_addtoinifiles "memcache.hash_strategy" "consistent"
	php-ext-source-r3_addtoinifiles "memcache.hash_function" "crc32"
	php-ext-source-r3_addtoinifiles "memcache.redundancy" "1"
	php-ext-source-r3_addtoinifiles "memcache.session_redundancy" "2"
	php-ext-source-r3_addtoinifiles "memcache.protocol" "ascii"
}
