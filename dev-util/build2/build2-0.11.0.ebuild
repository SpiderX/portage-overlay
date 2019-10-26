# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multiprocessing toolchain-funcs

MY_PN="${PN}-toolchain"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A cross-platform toolchain for building and packaging C++ code"
HOMEPAGE="https://build2.org"
SRC_URI="https://download.${PN}.org/${PV}/${MY_P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}"-nousrlocal.patch )

myb() {
	local myconfigargs=(
		--jobs "$(makeopts_jobs)"
		--verbose 2
		config.c="$(tc-getCC)"
		config.cxx="$(tc-getCXX)"
		config.cc.coptions="${CFLAGS}"
		config.cc.loptions="${LDFLAGS}"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.bin.lib=shared
		config.install.root="${ED}/usr/"
		config.install.lib="exec_root/$(get_libdir)"
		config.install.doc="data_root/share/doc/${PF}"
	)

	tc-is-gcc && export CCACHE_DISABLE=1
	export LD_LIBRARY_PATH="${S}/libbutl/libbutl:${S}/libpkgconf/libpkgconf:${LD_LIBRARY_PATH}"
	set -- "${@}" "${myconfigargs[@]}"
	echo "${@}"
	"${@}" || die "exec failed"
}

src_prepare() {
	default

	local pc
	pc="$(tc-getPKG_CONFIG)"

	printf 'cxx.libs += %s\ncxx.poptions += %s\n' \
		"$(${pc} sqlite3 --libs)" "$(${pc} sqlite3 --cflags)" >> \
		libodb-sqlite/buildfile \
		|| die "printf for libodb-sqlite/buildfile failed"
	sed -i -e 's:libsqlite3[/]\?::' buildfile build/bootstrap.build \
		|| die "sed for libsqlite3 failed"

	if has_version dev-util/pkgconf; then
		printf 'cxx.libs += %s\ncxx.poptions += %s\n' \
			"$(${pc} libpkgconf --libs)" "$(${pc} libpkgconf --cflags)" >> \
			build2/build2/buildfile \
			|| die "printf for build2/build2/buildfile failed"
		sed -i -e 's:libpkgconf[/]\?::' buildfile build/bootstrap.build \
			|| die "sed for libpkgconf failed"
	fi

	emake -C build2 -f bootstrap.gmake CXX="$(tc-getCXX)"
}

src_configure() {
	myb ./build2/build2/b-boot configure || die "myb configure failed"
}

src_compile() {
	myb ./build2/build2/b-boot update-for-install || die "myb compile failed"

	use test || return
	cp -a build2 testdir || die "test copying failed"
	cd testdir || die "cd to testdir failed"
	myb ./build2/b update-for-test || die "myb for test failed"
}

src_test() {
	cd testdir || die "change dir to testdir failed"
	myb ./build2/b test || die "myb test failed"
}

src_install() {
	myb ./build2/build2/b-boot install || die "myb install failed"
	docinto html
	dodoc "${ED}"/usr/share/doc/"${PF}"/*.xhtml
}
