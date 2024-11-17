# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="4c5e70cf399381de8fb485d4ed5a5c8fd7555146"

DESCRIPTION="A Common lisp library providing collector macros"
HOMEPAGE="https://github.com/AccelerationNet/collectors"
SRC_URI="https://github.com/AccelerationNet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/alexandria
	dev-lisp/closer-mop
	dev-lisp/symbol-munger"
BDEPEND="test? ( dev-lisp/lisp-unit2 )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :collectors)" \
		|| die "test failed"
}
