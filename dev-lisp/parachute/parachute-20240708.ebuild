# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3c04273cc61b353d7f1a087f9ae144f6f3fe4121"

DESCRIPTION="An extensible and cross-compatible testing framework"
HOMEPAGE="https://github.com/Shinmera/parachute"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/documentation-utils
	dev-lisp/form-fiddle
	dev-lisp/trivial-custom-debugger"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :parachute)" \
		|| die "test failed"
}
