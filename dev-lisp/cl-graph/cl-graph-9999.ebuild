# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp library for manipulating graphs"
HOMEPAGE="https://github.com/hraban/cl-graph"
EGIT_REPO_URI="https://github.com/hraban/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # https://github.com/hraban/cl-graph/issues/17

RDEPEND="dev-lisp/cl-containers
	dev-lisp/cl-mathstats
	dev-lisp/cl-variates
	dev-lisp/dynamic-classes
	dev-lisp/hu-dwim-graphviz
	dev-lisp/metabang-bind
	dev-lisp/metacopy
	dev-lisp/metatilities-base
	dev-lisp/moptilities"
DEPEND="${RDEPEND}
	dev-lisp/asdf-system-connections"
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

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl-graph)" \
		|| die "test failed"
}
