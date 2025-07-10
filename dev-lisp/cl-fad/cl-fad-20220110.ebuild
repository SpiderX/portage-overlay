# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3f4d32d3aa1093966046d001411a852eb8f4b535"

DESCRIPTION="Portable pathname library for Common Lisp"
HOMEPAGE="https://github.com/edicl/cl-fad"
SRC_URI="https://github.com/edicl/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/bordeaux-threads"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/cl-ppcre
		dev-lisp/unit-test )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-fad)" \
		|| die "test failed"
}
