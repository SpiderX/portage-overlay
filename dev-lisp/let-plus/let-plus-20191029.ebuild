# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="455e657e077235829b197f7ccafd596fcda69e30"

DESCRIPTION="Common Lisp Destructuring extension of LET"
HOMEPAGE="https://github.com/sharplispers/let-plus"
SRC_URI="https://github.com/sharplispers/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/anaphora"
BDEPEND="test? ( dev-lisp/uiop
		dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :let-plus/tests)" \
		|| die "test failed"
}
