# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="df7856f2a43fa91124fe780ef22f792040bc130c"

DESCRIPTION="Flexible Common Lisp shallow/deep copy mechanism"
HOMEPAGE="https://github.com/hraban/metacopy"
SRC_URI="https://github.com/hraban/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/contextl
	dev-lisp/moptilities"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :metacopy)" \
		|| die "test failed"
}
