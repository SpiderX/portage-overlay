# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 multiprocessing toolchain-funcs

DESCRIPTION="Command Line Interface compiler for C++"
HOMEPAGE="https://www.codesynthesis.com/projects/cli/"
EGIT_REPO_URI="https://git.codesynthesis.com/${PN}/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="doc static-libs"

RDEPEND="dev-cpp/libcutl"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/build2"

src_configure() {
	local myconfigargs=(
		config.bin.ar="$(tc-getAR)"
		config.bin.lib="$(usex static-libs both shared)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.install.doc="data_root/share/doc/${PF}"
		config.install.filter="manifest@false README@false"
		config.install.legal="${T}"
		config.install.lib="exec_root/$(get_libdir)"
	)

	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
	emake "${myconfigargs[@]}" configure: cli/
}

src_compile() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake cli/
}

src_test() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" emake test
}

src_install() {
	einstalldocs
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake config.install.root="${ED}/usr" install: cli/

	if ! use doc ; then
		rm "${ED}"/usr/share/doc/"${P}"/{default.css,cli.xhtml,cli-guide.xhtml} \
			|| die "rm for docs failed"
	fi
}
