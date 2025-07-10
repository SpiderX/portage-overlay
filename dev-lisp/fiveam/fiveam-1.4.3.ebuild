# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Common Lisp regression testing framework"
HOMEPAGE="https://github.com/lispci/fiveam"
SRC_URI="https://github.com/lispci/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria:0=
	dev-lisp/asdf-flv
	dev-lisp/trivial-backtrace"
BDEPEND="dev-lisp/asdf"

src_prepare() {
	default

	# use asdf-flv as package name
	sed -i -e 's/net\.didierverna\.//g' "${PN}.asd" "src/suite.lisp" \
		|| die "sed failed"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :fiveam)" \
		|| die "test failed"
}

src_install() {
	einstalldocs
	common-lisp-install-sources -t all src version.sexp
	common-lisp-install-asdf
}
