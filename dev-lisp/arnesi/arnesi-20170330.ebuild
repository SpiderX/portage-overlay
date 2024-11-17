# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="1e7dc4cb2cad8599113c7492c78f4925e839522e"

DESCRIPTION="A bag-of-tools utilities library"
HOMEPAGE="https://github.com/AccelerationNet/arnesi"
SRC_URI="https://github.com/AccelerationNet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # https://github.com/AccelerationNet/arnesi/issues/2

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/collectors
	dev-lisp/slime"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiveam )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :arnesi)" \
		|| die "test failed"
}
