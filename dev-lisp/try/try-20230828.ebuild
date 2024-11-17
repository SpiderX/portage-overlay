# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="cf2a8887d091bf297b72ef69e15012e7e849ba3b"

DESCRIPTION="Flexible bivalent streams for Common Lisp"
HOMEPAGE="https://github.com/melisgl/try"
SRC_URI="https://github.com/melisgl/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails

RDEPEND="dev-lisp/alexandria
	dev-lisp/closer-mop
	dev-lisp/cl-ppcre
	dev-lisp/ieee-floats
	dev-lisp/mgl-pax
	dev-lisp/named-readtables
	dev-lisp/pythonic-string-reader
	dev-lisp/trivial-gray-streams
	dev-lisp/uiop"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :try)" \
		|| die "test failed"
}

src_install() {
	einstalldocs
	common-lisp-install-sources -t all src test
	common-lisp-install-asdf
}
