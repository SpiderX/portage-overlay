# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="6c7b19ad1ea0d5c1e4386f16d202511c46c2eefd"

DESCRIPTION="An unordered collection of mathematical routines"
HOMEPAGE="https://github.com/hraban/cl-mathstats"
SRC_URI="https://github.com/hraban/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/cl-containers
	dev-lisp/metatilities-base"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-mathstats)" \
		|| die "test failed"
}
