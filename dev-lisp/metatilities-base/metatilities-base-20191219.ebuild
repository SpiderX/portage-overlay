# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="ef04337759972fd622c9b27b53149f3d594a841f"

DESCRIPTION="Metabang base set of core utilities"
HOMEPAGE="https://github.com/hraban/metatilities-base"
SRC_URI="https://github.com/hraban/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # 9 tests run, 4 Failures

BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :metatilities-base)" \
		|| die "test failed"
}
