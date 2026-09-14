# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="NGINX JavaScript"
HOMEPAGE="https://github.com/nginx/njs"
SRC_URI="https://github.com/nginx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs test tools +ssl +xml +zlib"
REQUIRED_USE="test? ( tools )"
RESTRICT="!test? ( test )"

RDEPEND="!www-nginx/njs[tools]
	dev-libs/libpcre2:0=
	dev-libs/quickjs-ng:0=
	tools? ( dev-libs/libedit:= )
	ssl? ( dev-libs/openssl:0= )
	xml? ( dev-libs/libxml2:2= )
	zlib? ( virtual/zlib:0= )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-tcltk/expect )"

PATCHES=( "${FILESDIR}/${PN}"-0.9.9-configure.patch
	"${FILESDIR}/${PN}"-0.9.9-no-werror.patch
	"${FILESDIR}/${PN}"-0.9.9-shared-lib.patch )

src_prepare() {
	default

	# auto/make currently hardcodes njs.pc as a build-tree pc file
	sed     -e "s#@PREFIX@#${EPREFIX}/usr#g" \
		-e "s#@LIBDIR@#${EPREFIX}\${prefix}/$(get_libdir)#g" \
		-e "s#@CFLAGS@#-I${EPREFIX}/usr/include#g" \
		-e "s#@VERSION@#${PV}#g" \
		-e "s#@EXTRA_LIBS@#-lm -lpcre2-8 -lqjs $(use ssl -lcrypto) $(use xml -lxml2) $(use zlib -lz)#g" \
		src/njs.pc.in > njs.pc || die "sed failed"
}

src_configure() {
	econf --ar="$(tc-getAR)" \
		--cc="$(tc-getCC)" \
		--ld-opt="${LDFLAGS}" \
		"$(usex debug --debug=YES --no-debug)" \
		"$(usex ssl --openssl --no-openssl)" \
		"$(usex xml --libxml2 --no-libxml2)" \
		"$(usex zlib --zlib --no-zlib)"
}

src_compile() {
	emake libnjs.so
	use static-libs && emake libnjs
	use tools || use test && emake njs
}

src_test() {
	# test262 fails in JS_FreeRuntime() assertions of QuickJS build
	emake lib_test shell_test unit_test
}

src_install() {
	einstalldocs

	doheader build/njs_auto_config.h src/*.h
	dolib.so build/libnjs.so{,."${PV}"}
	use static-libs && dolib.a build/libnjs.a
	use tools && dobin build/njs

	insinto /usr/"$(get_libdir)"/pkgconfig
	doins njs.pc
}
