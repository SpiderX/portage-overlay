# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

CLPACKAGE="${PN^}"
COMMIT="b4413bccc4d142cbe1bf49516c3a0a22c9d99243"

DESCRIPTION="A unit test library for Common Lisp"
HOMEPAGE="https://github.com/adlai/Eos"
SRC_URI="https://github.com/adlai/${PN^}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN^}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :Eos)" \
		|| die "test failed"
}
