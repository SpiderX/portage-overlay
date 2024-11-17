# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="08196426cb099db0623e6cae2aeca566e0b788b2"

DESCRIPTION="Cacro that generalizes multiple-value-bind"
HOMEPAGE="https://github.com/hraban/metabang-bind"
SRC_URI="https://github.com/hraban/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # 54 tests run, 4 Failures

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :metabang-bind)" \
		|| die "test failed"
}
