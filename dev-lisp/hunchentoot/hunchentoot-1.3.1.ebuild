# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Web server written in Common Lisp"
HOMEPAGE="https://github.com/edicl/hunchentoot"
SRC_URI="https://github.com/edicl/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/bordeaux-threads
	dev-lisp/chunga
	dev-lisp/cl-base64
	dev-lisp/cl-fad
	dev-lisp/cl-ppcre
	dev-lisp/cl-plus-ssl
	dev-lisp/flexi-streams
	dev-lisp/md5
	dev-lisp/rfc2388
	dev-lisp/trivial-backtrace
	dev-lisp/usocket"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/cl-who
		dev-lisp/drakma )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hunchentoot)" \
		|| die "test failed"
}
