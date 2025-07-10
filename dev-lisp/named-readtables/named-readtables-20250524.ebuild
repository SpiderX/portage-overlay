# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="8bd0045267007f03d7a59211d4446a1d8aa7c26c"

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
