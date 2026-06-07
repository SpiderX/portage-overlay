# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 multiprocessing toolchain-funcs

DESCRIPTION="ODB SQLite runtime library"
HOMEPAGE="https://codesynthesis.com/products/odb/"
EGIT_REPO_URI="https://github.com/codesynthesis-com/odb.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

DEPEND="dev-cpp/libcutl
	dev-libs/libstudxml"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/build2
	virtual/pkgconfig"

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
	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" emake update-for-install
	use test && MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake update-for-test
}

src_test() {
	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" emake test
}

src_install() {
	local myconfigargs=(
		config.install.chroot="${ED}"
		config.install.doc="${EPREFIX}"/usr/share/doc/"${PF}"
		config.install.filter="manifest@false LICENSE@false GPLv3@false"
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)"
		config.install.root="${EPREFIX}"/usr
	)

	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" install

	edo mkdir -p "${ED}"/usr/share/doc/"${PF}"/html
	edo mv -f "${ED}"/usr/share/doc/"${PF}"/{*.{css,png,xhtml},html}
}
