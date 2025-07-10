# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="d4f49d45257be1512db238a5c740e69a5964e93b"

DESCRIPTION="Common Lisp surface syntax niceties"
HOMEPAGE="https://github.com/edicl/cl-interpol"
SRC_URI="https://github.com/edicl/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/cl-unicode
	dev-lisp/named-readtables"
BDEPEND="test? ( dev-lisp/flexi-streams )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-interpol)" \
		|| die "test failed"
}
