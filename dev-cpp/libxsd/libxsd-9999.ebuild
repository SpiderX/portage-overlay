# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 multiprocessing toolchain-funcs

DESCRIPTION="A cross-platform W3C XML Schema to C++ data binding compiler library"
HOMEPAGE="https://www.codesynthesis.com/products/xsd/"
EGIT_REPO_URI="https://git.codesynthesis.com/${PN}/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND=">=dev-util/build2-0.16
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
		emake "${myconfigargs[@]}" configure: libxsd/
}

src_compile() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake libxsd/
}

src_test() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake test
}

src_install() {
	einstalldocs
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake config.install.root="${ED}/usr" install: libxsd/
}
