# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3f4d32d3aa1093966046d001411a852eb8f4b535"

DESCRIPTION="Parallelism for Common Lisp"
HOMEPAGE="https://github.com/lmj/lparallel"
SRC_URI="https://github.com/lmj/${PN}/archive/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria
	dev-lisp/bordeaux-threads
	dev-lisp/trivial-garbage"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :lparallel)" \
		|| die "test failed"
}
