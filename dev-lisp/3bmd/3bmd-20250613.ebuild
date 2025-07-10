# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="f850c88c34ac6f8c6a63e61aba2e677a6844648f"

DESCRIPTION="Markdown processor in Common Lisp using Esrap parser"
HOMEPAGE="https://github.com/3b/3bmd"
SRC_URI="https://github.com/3b/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/colorize
	dev-lisp/esrap
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiasco )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :3bmd)" \
		|| die "test failed"
}
