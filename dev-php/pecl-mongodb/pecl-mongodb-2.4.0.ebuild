# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="mongodb"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit edo php-ext-pecl-r3

DESCRIPTION="MongoDB database driver for PHP"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt debug sasl test"
REQUIRED_USE="test? ( debug )"
RESTRICT="x86? ( test ) !test? ( test )"

RDEPEND="dev-lang/php:*[ssl,zlib]
	>=dev-libs/libbson-2
	>=dev-libs/mongo-c-driver-${PV}[debug?,sasl?,ssl]
	dev-libs/openssl:=
	crypt? ( dev-libs/libmongocrypt )
	sasl? ( dev-libs/cyrus-sasl:2 )"
BDEPEND="virtual/pkgconfig
	test? ( dev-db/mongodb )"

# fix const-correctness with GCC 15 and -Werror=discarded-qualifiers.
PATCHES=( "${FILESDIR}/${PN}"-2.4.0-fix-const-qualifier.patch )

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
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	php-ext-pecl-r3_src_test
	edo kill "$(<"${T}/mongod.lock")"
}
