# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 multiprocessing toolchain-funcs

DESCRIPTION="A cross-platform W3C XML Schema to C++ data binding compiler library"
HOMEPAGE="https://www.codesynthesis.com/products/xsd/"
EGIT_REPO_URI="https://github.com/codesynthesis-com/xsd.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs"

BDEPEND="dev-build/build2"

src_configure() {
	local myconfigargs=(
		config.bin.ar="$(tc-getAR)"
		config.bin.lib="$(usex static-libs both shared)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
	)

	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" configure
}

src_compile() {
	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" emake
}

src_test() {
	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" emake test
}

src_install() {
	local myconfigargs=(
		config.install.chroot="${ED}"
		config.install.doc="${EPREFIX}"/usr/share/doc/"${PF}"
		config.install.filter="manifest@false LICENSE@false GPLv2@false FLOSSE@false"
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)"
		config.install.root="${EPREFIX}"/usr
	)

	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" install
}
