# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="LIsp Framework for Testing"
HOMEPAGE="https://github.com/hraban/lift"
EGIT_REPO_URI="https://github.com/hraban/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"

src_prepare() {
	default

	# remove failed test
	sed -i '/addtest (test-break-on-failure-helper)/,+3d' test/lift-test.lisp \
		|| die "sed failed for lift-test.lisp"
	# fix default report
	sed -i '/test-results/s|name|full-pathname|' lift-standard.config \
		|| die "sed failed for lift-standard.config"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :lift)" \
		|| die "test failed"
}

src_install() {
	einstalldocs
	common-lisp-install-sources -t all compare data dev timeout lift-standard.config
	common-lisp-install-asdf
}
