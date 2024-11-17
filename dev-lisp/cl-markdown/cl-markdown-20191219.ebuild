# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Portable simple API to work with backtraces in Common Lisp"
HOMEPAGE="https://gitlab.common-lisp.net/cl-markdown/cl-markdown"
SRC_URI="https://gitlab.common-lisp.net/${PN}/${PN}/-/archive/master/${PN}-master.tar.bz2"
S="${WORKDIR}/${PN}-master"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # some tests fail

RDEPEND="dev-lisp/anaphora
	dev-lisp/cl-containers
	dev-lisp/cl-html-diff
	dev-lisp/cl-ppcre
	dev-lisp/dynamic-classes
	dev-lisp/html-encode
	dev-lisp/lml2
	dev-lisp/metabang-bind
	dev-lisp/metatilities-base
	dev-lisp/trivial-shell"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/lift )"

src_prepare() {
	default

	# fix default report
	sed -i '/test-results/s|name|full-pathname|' lift-standard.config \
		|| die "sed failed for lift-standard.config"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-markdown)" \
		|| die "test failed"
}
