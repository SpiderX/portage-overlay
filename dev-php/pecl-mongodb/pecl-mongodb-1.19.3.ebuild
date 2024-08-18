# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="mongodb"
USE_PHP="php8-1 php8-2 php8-3"

inherit php-ext-pecl-r3

DESCRIPTION="MongoDB database driver for PHP"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt debug sasl test"
RESTRICT="x86? ( test ) !test? ( test )"

RDEPEND="dev-lang/php:*[ssl,zlib]
	>=dev-libs/libbson-1.27.5
	>=dev-libs/mongo-c-driver-1.27.5[sasl?,ssl]
	dev-libs/openssl:=
	crypt? ( dev-libs/libmongocrypt )
	sasl? ( dev-libs/cyrus-sasl:2 )"
BDEPEND="virtual/pkgconfig
	test? ( dev-db/mongodb )"

src_prepare() {
	# remove failed tests
	rm tests/logging/logging-addSubscriber-004.phpt \
		tests/cursor/bug1529-001.phpt \
		|| die "rm failed"

	php-ext-source-r3_src_prepare
}

src_configure() {
	local PHP_EXT_ECONF_ARGS=(
		--enable-mongodb
		--enable-mongodb-developer-flags="$(usex debug)"
		--with-mongodb-client-side-encryption="$(usex crypt)"
		--with-mongodb-system-libs=yes
		--with-mongodb-sasl="$(usex sasl)"
	)
	php-ext-source-r3_src_configure
}

src_test() {
	mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log" || die "mongod failed"
	php-ext-pecl-r3_src_test
	kill "$(<"${T}/mongod.lock")" || die "kill failed"
}
