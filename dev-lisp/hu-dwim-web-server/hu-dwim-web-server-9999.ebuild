# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EDARCS_REPOSITORY="https://hub.darcs.net/hu.dwim/hu.dwim.web-server"

inherit common-lisp-3 darcs

DESCRIPTION="Common Lisp iolib based HTTP server"
HOMEPAGE="https://hub.darcs.net/hu.dwim/hu.dwim.web-server"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc test"
RESTRICT="test" # HU.DWIM.DEF.NAMESPACE not found

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/babel
	dev-lisp/bordeaux-threads
	dev-lisp/cffi
	dev-lisp/cl-base64
	dev-lisp/cl-plus-ssl
	dev-lisp/drakma
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-computed-class
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-logger
	dev-lisp/hu-dwim-perec
	dev-lisp/hu-dwim-quasi-quote
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-uri
	dev-lisp/hu-dwim-zlib
	dev-lisp/iolib
	dev-lisp/ironclad
	dev-lisp/local-time
	dev-lisp/parse-number
	dev-lisp/rfc2109
	dev-lisp/rfc2388-binary
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.web-server.test)" \
		|| die "test failed"
}
