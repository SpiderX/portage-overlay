# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://git.codesynthesis.com/${PN}/${PN}.git"

inherit git-r3 multiprocessing toolchain-funcs

DESCRIPTION="A cross-platform W3C XML Schema to C++ data binding compiler"
HOMEPAGE="https://www.codesynthesis.com/products/xsd/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc examples zlib"

RDEPEND="dev-libs/xerces-c
	dev-libs/boost:=
	dev-cpp/libcutl
	dev-cpp/libxsd-frontend
	zlib? ( sys-libs/zlib:= )"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/build2
	dev-util/cli
	doc? ( app-doc/doxygen )"

src_configure() {
	local myconfigargs=(
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.install.lib="exec_root/$(get_libdir)"
		config.install.doc="data_root/share/doc/${PF}"
	)

	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" configure: libxsd/ xsd/
}

src_compile() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake libxsd/ xsd/
}

src_test() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake test
}

src_install() {
	einstalldocs
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake config.install.root="${ED}/usr" install: libxsd/ xsd/

	# Renaming binary/manpage to avoid collision with mono-2.0's xsd/xsd2
	mv "${ED}"/usr/bin/xsd{,cxx} \
		|| die "mv for xsd failed"
	mv "${ED}"/usr/share/man/man1/xsd{,cxx}.1 \
		|| die "mv for man failed"
}
