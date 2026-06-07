# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 multiprocessing toolchain-funcs

DESCRIPTION="A cross-platform W3C XML Schema to C++ data binding compiler"
HOMEPAGE="https://www.codesynthesis.com/products/xsd/"
EGIT_REPO_URI="https://github.com/codesynthesis-com/xsd.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs"

RDEPEND="dev-libs/xerces-c:0=
	dev-cpp/libcutl
	dev-cpp/libxsd-frontend"
DEPEND="${RDEPEND}"
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

	# renaming binary/manpage to avoid collision with mono-2.0's xsd/xsd2
	edo mv "${ED}"/usr/bin/xsd{,cxx}
	edo mv "${ED}"/usr/share/man/man1/xsd{,cxx}.1

	edo mkdir -p "${ED}"/usr/share/doc/"${PF}"/html
	edo mv -f "${ED}"/usr/share/doc/"${PF}"/{*.{css,xhtml},html}
	edo rm -rf "${ED}"/usr/share/doc/"${PF}"/{custom-literals.xsd,cxx}
}
