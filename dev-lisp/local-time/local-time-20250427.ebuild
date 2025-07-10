# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="fea5b154ad02e8eb68434c31770be6913c099d64"

DESCRIPTION="Time manipulation library for Common Lisp"
HOMEPAGE="https://github.com/dlowe-net/local-time"
SRC_URI="https://github.com/dlowe-net/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="postgres test"
RESTRICT="!test? ( test )" # some tests failed

RDEPEND="dev-lisp/uiop
	postgres? ( dev-lisp/postmodern )"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiasco )"

PATCHES=( "${FILESDIR}/${PN}"-20250427-system-zoneinfo.patch )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :local-time)" \
		|| die "test failed"
}
