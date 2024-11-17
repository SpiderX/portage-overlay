# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="f9babc7827d19b729098c46f66f32daa4c966299"
MY_PN="${PN//-/.}"

DESCRIPTION="Customizable partial evaluation for Common Lisp"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.partial-eval"
SRC_URI="https://github.com/hu-dwim/${MY_PN//.eval/-eval}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN//.eval/-eval}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="test" # build error

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-def
	dev-lisp/hu-dwim-defclass-star
	dev-lisp/hu-dwim-logger
	dev-lisp/slime
	dev-lisp/hu-dwim-syntax-sugar
	dev-lisp/hu-dwim-walker"
BDEPEND="test? ( dev-lisp/asdf
		dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.partial-eval.test)" \
		|| die "test failed"
}
