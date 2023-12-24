# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing toolchain-funcs

DESCRIPTION="A compiler frontend for the W3C XML Schema definition language"
HOMEPAGE="https://www.codesynthesis.com/projects/libxsd-frontend/"
SRC_URI="https://www.codesynthesis.com/download/xsd/4.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-cpp/libcutl
	dev-libs/boost:=
	dev-libs/xerces-c"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-util/build2-0.16"

src_configure() {
	local myconfigargs=(
		config.bin.ar="$(tc-getAR)"
		config.bin.lib="$(usex static-libs both shared)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.install.doc="data_root/share/doc/${PF}"
		config.install.filter="manifest@false"
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
		emake config.install.root="${ED}/usr" install
}
