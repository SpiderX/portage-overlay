# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PV="release-${PV}"

DESCRIPTION="Compressed data in the ZLIB, DEFLATE, or GZIP data formats"
HOMEPAGE="https://github.com/xach/salza2"
SRC_URI="https://github.com/xach/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/chipz
		dev-lisp/flexi-streams
		dev-lisp/parachute )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :salza2)" \
		|| die "test failed"
}
