# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://git.codesynthesis.com/${PN}/${PN}.git"

inherit git-r3 multiprocessing toolchain-funcs

DESCRIPTION="Command Line Interface compiler for C++"
HOMEPAGE="https://www.codesynthesis.com/projects/cli/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

RDEPEND="dev-cpp/libcutl"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/build2"

src_prepare() {
	default

	# Fix headers
	sed -i '/<cutl/s/cutl/libcutl/' cli/context.hxx \
		|| die "sed failed for cli/context.hxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/elements.hxx \
		|| die "sed failed for cli/semantics/elements.hxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/traversal/elements.hxx \
		|| die "sed failed for cli/traversal/elements.hxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/generator.cxx \
		|| die "sed failed for cli/generator.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/namespace.cxx \
		|| die "sed failed for cli/semantics/namespace.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/doc.cxx \
		|| die "sed failed for cli/semantics/doc.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/class.cxx \
		|| die "sed failed for cli/semantics/class.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/expression.cxx \
		|| die "sed failed for cli/semantics/expression.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/elements.cxx \
		|| die "sed failed for cli/semantics/elements.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/unit.cxx \
		|| die "sed failed for cli/semantics/unit.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/semantics/option.cxx \
		|| die "sed failed for cli/semantics/option.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/cli.cxx \
		|| die "sed failed for cli/cli.cxx"
	sed -i '/<cutl/s/cutl/libcutl/' cli/version.hxx.in \
		|| die "sed failed for cli/version.hxx.in"
}

src_configure() {
	local myconfigargs=(
		config.cxx="$(tc-getCXX)"
		config.cxx.coptions="${CXXFLAGS}"
		config.cxx.loptions="${LDFLAGS}"
		config.bin.ar="$(tc-getAR)"
		config.bin.ranlib="$(tc-getRANLIB)"
		config.bin.lib="$(usex static-libs both shared)"
		config.install.lib="exec_root/$(get_libdir)"
		config.install.doc="data_root/share/doc/${PF}"
	)

	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
	emake "${myconfigargs[@]}" configure
}

src_compile() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake
}

src_test() {
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake test
}

src_install() {
	einstalldocs
	MAKE=b MAKEOPTS="--jobs $(makeopts_jobs) -V" \
		emake config.install.root="${ED}/usr" install
}
