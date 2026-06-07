# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multiprocessing toolchain-funcs

DESCRIPTION="Common ODB runtime library"
HOMEPAGE="https://codesynthesis.com/products/odb/"
SRC_URI="https://codesynthesis.com/download/odb/${PV}/${P}.tar.gz
	https://pkg.cppget.org/1/stable/odb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

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
		config.install.filter="manifest@false LICENSE@false GPLv2@false"
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)"
		config.install.root="${EPREFIX}"/usr
	)

	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" install
}
