# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PN="cl-lml2"

DESCRIPTION="Lisp Markup Language"
HOMEPAGE="https://tracker.debian.org/pkg/cl-lml2"
SRC_URI="mirror://debian/pool/main/c/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/kmrcl"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :lml2)" \
		|| die "test failed"
}
