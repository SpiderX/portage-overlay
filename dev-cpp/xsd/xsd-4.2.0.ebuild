# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing toolchain-funcs

DESCRIPTION="A cross-platform W3C XML Schema to C++ data binding compiler"
HOMEPAGE="https://www.codesynthesis.com/products/xsd/"
SRC_URI="https://www.codesynthesis.com/download/${PN}/${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test zlib"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/xerces-c
	dev-libs/boost:=
	dev-cpp/libcutl
	dev-cpp/libxsd-frontend
	zlib? ( sys-libs/zlib:= )"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-util/build2-0.16
	dev-util/cli
	doc? ( app-text/doxygen )"

src_configure() {
	local myconfigargs=(
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.install.doc="data_root/share/doc/${PF}"
		config.install.filter="manifest@false PACKAGE-README.md@false"
		config.install.legal="${T}"
		config.install.lib="exec_root/$(get_libdir)"
	)

	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" configure
}

src_compile() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake
}

src_test() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake test
}

src_install() {
	einstalldocs
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake config.install.root="${ED}/usr/" install

	# Renaming binary/manpage to avoid collision with mono-2.0's xsd/xsd2
	mv "${ED}"/usr/bin/xsd{,cxx} \
		|| die "mv for xsd failed"
	mv "${ED}"/usr/share/man/man1/xsd{,cxx}.1 \
		|| die "mv for man failed"

	if ! use doc ; then
		rm "${ED}"/usr/share/doc/"${P}"/{default.css,xsd.xhtml} \
			|| die "rm for xsd.xhtml.bz2 failed"
	fi

	if ! use examples ; then
		rm -rf "${ED}"/usr/share/doc/"${P}"/{custom-literals.xsd,cxx} \
			|| die "rm for cxx failed"
	fi
}
