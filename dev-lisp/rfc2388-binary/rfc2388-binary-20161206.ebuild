# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Parsing multipart/form-data data streams library"
HOMEPAGE="https://gitlab.common-lisp.net/ucw/rfc2388-binary"
SRC_URI="https://gitlab.common-lisp.net/ucw/${PN}/-/archive/master/${PN}-master.tar.bz2"
S="${WORKDIR}/${PN}-master"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # tests not ready

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/arnesi
		dev-lisp/fiveam )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :rfc2388-binary)" \
		|| die "test failed"
}
