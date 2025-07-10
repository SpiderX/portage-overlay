# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="5008c4e4cac5dad8f00438c6d335f36bc4fa6747"

DESCRIPTION="Trivial command-line argument parsing library for Common Lisp"
HOMEPAGE="https://github.com/fare/command-line-arguments"
SRC_URI="https://github.com/fare/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # build fails

RDEPEND="dev-lisp/uiop"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/alexandria
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :command-line-arguments)" \
		|| die "test failed"
}
