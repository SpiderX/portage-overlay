# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mongodb/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Client library written in C for MongoDB"
HOMEPAGE="https://github.com/mongodb/mongo-c-driver"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="aws debug sasl snappy +ssl static-libs test zlib zstd"
REQUIRED_USE="aws? ( ssl ) test? ( static-libs )"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-libs/libbson-${PV}[static-libs?]
	>=dev-libs/libmongocrypt-1.11.0
	dev-libs/libutf8proc[static-libs?]
	sasl? ( dev-libs/cyrus-sasl:2 )
	snappy? ( app-arch/snappy:0= )
	ssl? ( dev-libs/openssl:= )
	zlib? ( sys-libs/zlib:0= )
	zstd? ( app-arch/zstd:0= )"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	# remove doc files, build test and not fail on system wide libbson
	sed -i  -e '/^\s*install\s*(FILES COPYING NEWS/,/^\s*)/ {d}' \
		-e '/SET (ENABLE_TESTS OFF)/d' \
		-e '/System libbson built without static/s|FATAL_ERROR|STATUS|' \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"

	# copy private headers for system wide libbson
	if use test ; then
		mkdir -p src/libbson/tests/bson || die "mkdir failed"
		cp src/libbson/src/bson/bson-*.h src/libbson/tests/bson \
			|| die "cp failed"
		sed -i 's#<bson/bson-private.h>#"bson/bson-private.h"#' \
			src/libbson/tests/test-bson.c || die "sed failed for test-bson.c"
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CLIENT_SIDE_ENCRYPTION=ON
		-DENABLE_EXAMPLES=OFF
		-DENABLE_MONGODB_AWS_AUTH="$(usex aws ON OFF)"
		-DENABLE_SASL="$(usex sasl CYRUS OFF)"
		-DENABLE_SNAPPY="$(usex snappy ON OFF)"
		-DENABLE_SSL="$(usex ssl OPENSSL OFF)"
		-DENABLE_STATIC="$(usex static-libs ON OFF)"
		-DENABLE_TESTS="$(usex test ON OFF)"
		-DENABLE_TRACING="$(usex debug ON OFF)"
		-DENABLE_UNINSTALL=OFF
		-DENABLE_ZLIB="$(usex zlib SYSTEM OFF)"
		-DENABLE_ZSTD="$(usex zstd ON OFF)"
		-DUSE_BUNDLED_UTF8PROC=OFF
		-DUSE_SYSTEM_LIBBSON=ON
	)
	cmake_src_configure
}

src_test() {
	cat > "${S}"/skip-test.txt <<EOF
/http/get # no simplehttp
/http/post # no simplehttp
/TOPOLOGY/happy_eyeballs/1 # no ipv6
/TOPOLOGY/happy_eyeballs/2 # no ipv6
/TOPOLOGY/happy_eyeballs/3 # no ipv6
/TOPOLOGY/happy_eyeballs/4 # no ipv6
/TOPOLOGY/happy_eyeballs/5 # no ipv6
/TOPOLOGY/happy_eyeballs/6 # no ipv6
/TOPOLOGY/happy_eyeballs/7 # no ipv6
/TOPOLOGY/happy_eyeballs/8 # no ipv6
/TOPOLOGY/happy_eyeballs/9 # no ipv6
/TOPOLOGY/happy_eyeballs/10 # no ipv6
/TOPOLOGY/happy_eyeballs/11 # no ipv6
/TOPOLOGY/happy_eyeballs/12 # no ipv6
/TOPOLOGY/happy_eyeballs/13 # no ipv6
/TOPOLOGY/happy_eyeballs/14 # no ipv6
/TOPOLOGY/happy_eyeballs/15 # no ipv6
/TOPOLOGY/happy_eyeballs/16 # no ipv6
/TOPOLOGY/happy_eyeballs/17 # no ipv6
/TOPOLOGY/happy_eyeballs/18 # no ipv6
/TOPOLOGY/happy_eyeballs/dns_cache/ # no ipv6
/TOPOLOGY/scanner_connection_error # connection refused calling hello on 'localhost:9876'
/TOPOLOGY/dns # no ipv6
EOF
	export MONGOC_TEST_SKIP_LIVE=on
	../mongo-c-driver-"${PV}"_build/src/libmongoc/test-libmongoc \
		--skip-tests "${S}"/skip-test.txt || die "test-libmongoc failed"
}
