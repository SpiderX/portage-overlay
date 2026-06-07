# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo multiprocessing toolchain-funcs

DESCRIPTION="Command Line Interface compiler for C++"
HOMEPAGE="https://www.codesynthesis.com/projects/cli/"
SRC_URI="https://github.com/codesynthesis-com/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"
RESTRICT="test"

RDEPEND="dev-cpp/libcutl"
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
		emake "${myconfigargs[@]}" configure: cli/
}

src_compile() {
	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" emake cli/
}

src_test() {
	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" emake test
}

src_install() {
	local myconfigargs=(
		config.install.chroot="${ED}"
		config.install.doc="${EPREFIX}"/usr/share/doc/"${PF}"
		config.install.filter="manifest@false LICENSE@false"
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)"
		config.install.root="${EPREFIX}"/usr
	)

	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" install: cli/

	edo mkdir -p "${ED}"/usr/share/doc/"${PF}"/html
	edo mv -f "${ED}"/usr/share/doc/"${PF}"/{*.{css,xhtml},html}
}
