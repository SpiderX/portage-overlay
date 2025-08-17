# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

MY_PN="IntelRDFPMathLib"
MY_PV="$(ver_cut 1)$(ver_cut 2)U$(ver_cut 3-)"
MY_P="${MY_PN}${MY_PV}"

DESCRIPTION="Library routines related to building,parsing and iterating BSON documents"
HOMEPAGE="https://software.intel.com/en-us/articles/intel-decimal-floating-point-math-library"
SRC_URI="http://www.netlib.org/misc/intel/${MY_P}.tar.gz"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}"/abs-declaration.patch
	"${FILESDIR}"/disable-test-werror.patch
	"${FILESDIR}"/inject-buildflags.patch
	"${FILESDIR}"/mongo-inteldfp-libmongocrypt-pr-625.patch
	"${FILESDIR}"/mongo-inteldfp-MONGOCRYPT-571.patch
	"${FILESDIR}"/wchar_t.patch )

src_prepare() {
	default

	append-flags -fPIC

	# prevent collide with portage ${A}
	sed -i '/^BID_LIB/s|$A|a|' LIBRARY/makefile || die "sed failed for LIBRARY/makefile"
}

src_compile() {
	emake -C LIBRARY OS_TYPE=LINUX CC=gcc CALL_BY_REF=0 GLOBAL_RND=0 GLOBAL_FLAGS=0 UNCHANGED_BINARY_FLAGS=0
	use test && emake -C TESTS OS_TYPE=LINUX CC=gcc CALL_BY_REF=0 GLOBAL_RND=0 GLOBAL_FLAGS=0 UNCHANGED_BINARY_FLAGS=0
}

src_test() {
	TESTS/readtest < TESTS/readtest.in || die "readtest failed"
}

src_install() {
	einstalldocs
	insinto /usr/include
	doins -r LIBRARY/src/*.h
	exeinto /usr/"$(get_libdir)"
	doexe LIBRARY/libbid.a
}
