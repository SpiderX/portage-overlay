# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo multiprocessing toolchain-funcs

DESCRIPTION="Streaming XML pull parser and streaming XML serializer"
HOMEPAGE="https://codesynthesis.com/projects/libstudxml/"
SRC_URI="https://codesynthesis.com/download/odb/2.5.0/${P}.tar.gz
	https://pkg.cppget.org/1/stable/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="expat static-libs test"
RESTRICT="!test? ( test )"

DEPEND="expat? ( dev-libs/expat )"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/build2
	virtual/pkgconfig"

src_prepare() {
	default

	use expat && eapply "${FILESDIR}/${PN}"-1.1.0-expat.patch
}

src_configure() {
	local myconfigargs=(
		config.bin.ar="$(tc-getAR)"
		config.bin.lib="$(usex static-libs both shared)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.libstudxml.external_expat="$(usex expat true false)"
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
		config.install.filter="manifest@false LICENSE@false EXPAT-LICENSE@false GENX-LICENSE@false"
		config.install.lib="${EPREFIX}"/usr/"$(get_libdir)"
		config.install.root="${EPREFIX}"/usr
	)

	MAKE=b MAKEOPTS="-j $(makeopts_jobs) -V" \
		emake "${myconfigargs[@]}" install

	edo mkdir -p "${ED}"/usr/share/doc/"${PF}"/html
	edo mv -f "${ED}"/usr/share/doc/"${PF}"/{*.{xhtml,css},html}
}
