# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PN="cl-py-configparser"

DESCRIPTION="ConfigParser Python module functionality in Common Lisp"
HOMEPAGE="https://tracker.debian.org/pkg/cl-py-configparser"
SRC_URI="mirror://debian/pool/main/c/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}-svn"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/parse-number"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/rt )"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :py-configparser)" \
		|| die "test failed"
}
