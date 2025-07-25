# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="0c84b29a32c284f6b4be6f8587ff89b5702a6fda"

DESCRIPTION="Common Lisp JSON serializer written with simplicity in mind"
HOMEPAGE="https://github.com/phmarek/yason"
SRC_URI="https://github.com/phmarek/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/unit-test )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :yason)" \
		|| die "test failed"
}
