# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="7e56daf73f0ed5f49a931c01af75fb874bcf3445"

DESCRIPTION="MySQL Native Driver for Common Lisp"
HOMEPAGE="https://github.com/qitab/qmynd"
SRC_URI="https://github.com/qitab/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

RDEPEND="dev-lisp/asdf-finalizers
	dev-lisp/babel
	dev-lisp/chipz
	dev-lisp/flexi-streams
	dev-lisp/ironclad
	dev-lisp/salza2
	dev-lisp/trivial-gray-streams
	dev-lisp/uiop
	dev-lisp/usocket
	ssl? ( dev-lisp/cl-plus-ssl )"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :qmynd)" \
		|| die "test failed"
}
