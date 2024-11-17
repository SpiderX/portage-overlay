# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="455fbaaf5aed25e296edb513fce8819c655977e8"

DESCRIPTION="Flexible bivalent streams for Common Lisp"
HOMEPAGE="https://github.com/melisgl/named-readtables"
SRC_URI="https://github.com/melisgl/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-lisp/mgl-pax"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/pythonic-string-reader
		dev-lisp/try )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :named-readtables-test)" \
		|| die "test failed"
}
