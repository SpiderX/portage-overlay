# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multiprocessing

MY_PN="${PN}"-toolchain
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Cross-platform toolchain for building and packaging C++ code"
HOMEPAGE="https://build2.org"
SRC_URI="https://download.build2.org/${PV}/${MY_P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-cpp/libodb
	dev-cpp/libodb-sqlite
	dev-db/sqlite:3"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}"-0.14.0-update-for-install.patch
	"${FILESDIR}/${PN}"-0.16.0-gcc-13-segfault.patch )

b() {
	local myargs=(
		--jobs "$(makeopts_jobs)"
		--verbose 3
	)
	export LD_LIBRARY_PATH="${S}/libbutl/libbutl:${S}/build2/libbuild2:${S}/build2/libbuild2/bash:${S}/build2/libbuild2/in:${S}/build2/libbuild2/bin:${S}/build2/libbuild2/c:${S}/build2/libbuild2/cc:${S}/build2/libbuild2/cxx:${S}/build2/libbuild2/version:${S}/libpkgconf/libpkgconf:${LD_LIBRARY_PATH}"
	set -- "${S}"/build2/build2/b-boot "${@}" "${myargs[@]}"
	echo "${@}"
	"${@}" || die "\${@} failed"
}

src_prepare() {
	# Unbundle dev-cpp/libodb and dev-cpp/libodb-sqlite
	printf 'cxx.libs += %s\ncxx.poptions += %s\n' \
		"-L${EPREFIX}/usr/$(get_libdir) $($(tc-getPKG_CONFIG) sqlite3 --libs)" \
		"$($(tc-getPKG_CONFIG) sqlite3 --cflags)" >> \
		libodb-sqlite/buildfile \
		|| die "printf failed for libodb-sqlite/buildfile"
	sed -i \
		-e 's:libsqlite3[/]\?::' \
		buildfile build/bootstrap.build \
		|| die
	for i in build2/build2/buildfile build2/libbuild2/buildfile; do
		printf 'cxx.libs += %s\ncxx.poptions += %s\n' \
			   "$($(tc-getPKG_CONFIG) libodb --libs)" \
			   "$($(tc-getPKG_CONFIG) libodb --cflags)" >> \
			   "${i}" \
			|| die "printf failed for ${i}"
		printf 'cxx.libs += %s\ncxx.poptions += %s\n' \
			"$($(tc-getPKG_CONFIG) libodb-sqlite --libs)" \
			"$($(tc-getPKG_CONFIG) libodb-sqlite --cflags)" >> \
			"${i}" || die "printf failed for ${i}"
	done
	sed -i \
		-e 's:libodb-sqlite[/]\?::' \
		-e 's:libodb[/]\?::' \
		buildfile build/bootstrap.build \
		|| die "sed failed for libodb in build/bootstrap.build"

	if has_version dev-util/pkgconf; then
		for i in build2/build2/buildfile build2/libbuild2/buildfile; do
			printf 'cxx.libs += %s\ncxx.poptions += %s\n' \
				"$($(tc-getPKG_CONFIG) libpkgconf --libs)" \
				"$($(tc-getPKG_CONFIG) libpkgconf --cflags)" >> \
				"${i}" \
				|| die "printf failed for ${i}"
		done
		sed \
			-e 's:libpkgconf[/]\?::' \
			-i buildfile build/bootstrap.build \
			|| die "sed failed for libpkgconf in build/bootstrap.build"
	fi

	default
}

src_configure() {
	emake -C build2 -f bootstrap.gmake \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}"

	b configure \
		config.cxx="$(tc-getCXX)" \
		config.cxx.coptions="${CXXFLAGS}" \
		config.cxx.loptions="${LDFLAGS}" \
		config.c="$(tc-getCC)" \
		config.cc.coptions="${CFLAGS}" \
		config.cc.loptions="${LDFLAGS}" \
		config.bin.ar="$(tc-getAR)" \
		config.bin.ranlib="$(tc-getRANLIB)" \
		config.bin.lib=shared \
		config.install.root="${EPREFIX}"/usr \
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)" \
		config.install.doc="${EPREFIX}"/usr/share/doc/"${PF}"
}

src_compile() {
	b update-for-install
	use test && b update-for-test
}

src_test() {
	b test
}

src_install() {
	b install: build2/ bpkg/ bdep/ libbuild2-kconfig/ \
		config.install.chroot="${D}"
	rm -rf "${ED}"/usr/include/odb \
		"${ED}"/usr/include/pkgconf/libpkgconf \
		|| die "rm failed for /usr/include"
	rm -f "${ED}"/usr/include/sqlite3.h \
		"${ED}"/usr/include/sqlite3ext.h \
		"${ED}"/usr/"$(get_libdir)"/libodb.so \
		"${ED}"/usr/"$(get_libdir)"/libodb-*.so \
		"${ED}"/usr/"$(get_libdir)"/libodb-sqlite.so \
		"${ED}"/usr/"$(get_libdir)"/libodb-sqlite-*.so \
		"${ED}"/usr/"$(get_libdir)"/libpkgconf.so \
		"${ED}"/usr/"$(get_libdir)"/libsqlite3.so \
		"${ED}"/usr/"$(get_libdir)"/pkgconfig/libodb-sqlite.pc \
		"${ED}"/usr/"$(get_libdir)"/pkgconfig/libodb.shared.pc \
		"${ED}"/usr/"$(get_libdir)"/pkgconfig/libodb-sqlite.shared.pc \
		"${ED}"/usr/"$(get_libdir)"/pkgconfig/libpkgconf.pc \
		"${ED}"/usr/"$(get_libdir)"/pkgconfig/libodb.pc \
		|| die "rm failed for libdir"
	mkdir -p "${ED}"/usr/share/doc/"${PF}"/html || die "mkdir failed"
	mv -f "${ED}"/usr/share/doc/"${PF}"/*.xhtml "${ED}"/usr/share/doc/"${PF}"/html \
		|| die "mv failed"
}
