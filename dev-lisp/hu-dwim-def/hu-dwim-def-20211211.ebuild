# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="6801c4c483869e3db5d1d598a292322f6ee4cd92"
MY_PN="${PN//-/.}"

DESCRIPTION="One macro to define them all"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.def"
SRC_URI="https://github.com/hu-dwim/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
REQUIRED_USE="doc? ( test )"
RESTRICT="!test? ( test )"

PDEPEND="dev-lisp/hu-dwim-util"
RDEPEND="dev-lisp/alexandria
	dev-lisp/anaphora
	dev-lisp/bordeaux-threads
	dev-lisp/cl-l10n
	dev-lisp/contextl
	dev-lisp/hu-dwim-asdf
	dev-lisp/hu-dwim-common
	dev-lisp/hu-dwim-delico
	dev-lisp/iterate
	dev-lisp/metabang-bind
	dev-lisp/slime
	dev-lisp/trivial-garbage
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/hu-dwim-stefil
		dev-lisp/optima )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :hu.dwim.def)" \
		|| die "test failed"
}
