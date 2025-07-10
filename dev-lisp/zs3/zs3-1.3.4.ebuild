# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PV="release-${PV}"

DESCRIPTION="Common Lisp library for working with Amazon's S3"
HOMEPAGE="https://github.com/xach/zs3"
SRC_URI="https://github.com/xach/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
