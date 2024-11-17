# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="23c14409dc89538b8a0bb2667a9784a5a72b795f"

DESCRIPTION="A charset encoding/decoding library"
HOMEPAGE="https://github.com/cl-babel/babel"
SRC_URI="https://github.com/cl-${PN}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/trivial-features
	dev-lisp/trivial-gray-streams"
BDEPEND="test? ( dev-lisp/hu-dwim-stefil )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :babel)" \
		|| die "test failed"
}
