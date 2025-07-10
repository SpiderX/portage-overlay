# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="a4ee4410ad3e42dcefdfa4ae8c2b40d15257de3e"

DESCRIPTION="HTTP client written in Common Lisp"
HOMEPAGE="https://github.com/edicl/drakma"
SRC_URI="https://github.com/edicl/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lisp/chipz
	dev-lisp/chunga
	dev-lisp/cl-base64
	dev-lisp/cl-ppcre
	dev-lisp/cl-plus-ssl
	dev-lisp/flexi-streams
	dev-lisp/puri
	dev-lisp/usocket"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiveam
		dev-lisp/hunchentoot )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :drakma)" \
		|| die "test failed"
}
