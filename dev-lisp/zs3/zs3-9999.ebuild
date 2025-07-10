# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp library for working with Amazon's S3"
HOMEPAGE="https://github.com/xach/zs3"
EGIT_REPO_URI="https://github.com/xach/${PN}.git"

LICENSE="BSD-2"
SLOT="0"
RESTRICT="test" # tests requires S3 bucket

RDEPEND="dev-lisp/alexandria
	dev-lisp/cl-base64
	dev-lisp/cxml
	dev-lisp/drakma
	dev-lisp/ironclad
	dev-lisp/puri"
BDEPEND="dev-lisp/asdf"

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :zs3)" \
		|| die "test failed"
}
