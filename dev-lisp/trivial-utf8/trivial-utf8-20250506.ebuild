# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PN="${PN//8/-8}"
CLPACKAGE="${MY_PN}"
CLSYSTEMS="${MY_PN}"

DESCRIPTION="Portable simple API to work with backtraces in Common Lisp"
HOMEPAGE="https://gitlab.common-lisp.net/trivial-utf-8/trivial-utf-8"
SRC_URI="https://gitlab.common-lisp.net/${MY_PN}/${MY_PN}/-/archive/master/${MY_PN}-master.tar.bz2"
S="${WORKDIR}/${MY_PN}-master"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # WRITE-UTF-8-BYTES is undefined

PDEPEND="dev-lisp/mgl-pax"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :trivial-utf-8/tests)" \
		|| die "test failed"
}
