# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="98eb335c693f1881584b83ca7be4a0fe05355c4e"

DESCRIPTION="A Common Lisp library for computing differences between sequences"
HOMEPAGE="https://github.com/wiseman/cl-difflib"
SRC_URI="https://github.com/wiseman/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"

PATCHES=( "${FILESDIR}/${PN}"-20090602-tests.patch )

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-difflib)" \
		|| die "test failed"
}
