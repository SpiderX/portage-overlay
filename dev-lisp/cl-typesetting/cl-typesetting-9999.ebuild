# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mbattyani/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp Typesetting system"
HOMEPAGE="https://github.com/mbattyani/cl-typesetting"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-lisp/cl-pdf
	dev-lisp/xmls"
BDEPEND="dev-lisp/asdf"

PATCHES=( "${FILESDIR}/${PN}"-20210414-path.patch )

# tests not ready
src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-typesetting)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/cl-typesetting
	doins -r hyphen-patterns
}
