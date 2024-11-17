# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="b5aa17b298cf2f669f4c0262c471e1ee4ab4699a"

DESCRIPTION="A Test Framework for Common Lisp in the style of JUnit"
HOMEPAGE="https://github.com/AccelerationNet/lisp-unit2"
SRC_URI="https://github.com/AccelerationNet/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-interpol
	dev-lisp/iterate
	dev-lisp/symbol-munger"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :lisp-unit2)" \
		|| die "test failed"
}
