# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="6c86084d457bc8b95011669231e3e93e750351f9"
MY_PV="version-${PV}"

DESCRIPTION="Portable Common Lisp Random Number Generation"
HOMEPAGE="https://gitlab.common-lisp.net/cl-variates/cl-variates"
SRC_URI="https://gitlab.common-lisp.net/${PN}/${PN}/-/archive/${MY_PV}/${P}.tar.bz2"
S="${WORKDIR}/${PN}-${MY_PV}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" #Unhandled LOAD-SYSTEM-DEFINITION-ERROR

RDEPEND="dev-lisp/metacopy"
BDEPEND="test? ( dev-lisp/lift )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-variates)" \
		|| die "test failed"
}
