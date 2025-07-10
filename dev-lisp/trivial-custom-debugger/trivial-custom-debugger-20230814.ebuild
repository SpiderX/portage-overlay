# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="802473c75d9db625b8f37b05c95dde47b67c52fa"

DESCRIPTION="Allows arbitrary functions to become the standard Lisp debugger"
HOMEPAGE="https://github.com/phoe/trivial-custom-debugger"
SRC_URI="https://github.com/phoe/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/parachute )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :trivial-custom-debugger)" \
		|| die "test failed"
}
