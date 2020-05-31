# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

MY_PV="7c69e80"

DESCRIPTION="A compiler frontend for the W3C XML Schema definition language"
HOMEPAGE="https://www.codesynthesis.com/projects/libxsd-frontend"
SRC_URI="https://git.codesynthesis.com/cgit/${PN}/${PN}/snapshot/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-cpp/libcutl
	dev-libs/boost:=[threads]
	dev-libs/xerces-c"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/build"

src_configure() {
	mkdir -p \
		build/{ld,cxx/gnu} \
		build/import/lib{boost,cult,frontend-elements,xerces-c} \
		|| die "mkdir failed"

	cat >> build/cxx/configuration-dynamic.make <<- EOF || die "cat for cxx failed"
		cxx_id       := gnu
		cxx_optimize := n
		cxx_debug    := n
		cxx_rpath    := n
		cxx_pp_extra_options :=
		cxx_extra_options    := ${CXXFLAGS}
		cxx_ld_extra_options := ${LDFLAGS}
		cxx_extra_libs       :=
		cxx_extra_lib_paths  :=
	EOF

	cat >> build/cxx/gnu/configuration-dynamic.make <<- EOF || die "cat for gnu failed"
		cxx_gnu := $(tc-getCXX)
		cxx_gnu_libraries :=
		cxx_gnu_optimization_options :=
	EOF

	cat >> build/ld/configuration-lib-dynamic.make <<- EOF || die "cat for ld failed"
		ld_lib_type   := shared
	EOF

	# boost
	cat >> build/import/libboost/configuration-dynamic.make <<- EOF || die "cat for libboost failed"
		libboost_installed := y
		libboost_system := y
	EOF

	# libcutl
	cat >> build/import/libcutl/configuration-dynamic.make <<- EOF || die "cat for libcutl failed"
		libcutl_installed := y
	EOF

	# xerces-c
	cat >> build/import/libxerces-c/configuration-dynamic.make <<- EOF || die "cat for libxerces failed"
		libxerces_c_installed := y
	EOF
}

src_compile() {
	emake verbose=1
}

src_test() {
	export LD_LIBRARY_PATH="${S}/xsd-frontend:${LD_LIBRARY_PATH}"
	default
}

src_install() {
	einstalldocs

	dolib.so xsd-frontend/libxsd-frontend.so

	# clean header dir of build files
	find xsd-frontend \( -iname '*.cxx' -o -iname 'makefile*' \
		-o -iname '*.o' -o -iname '*.d' -o -iname '*.m4' -o -iname '*.l' \
		-o -iname '*.cpp-options' -o -iname '*.so' \) -exec rm -rf '{}' + \
		|| die "find failed"
	rm -rf xsd-frontend/arch || die "rm failed"
	doheader -r xsd-frontend
}
