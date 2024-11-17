# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/wiseman/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp library for generating a human-readable diff"
HOMEPAGE="https://github.com/wiseman/cl-html-diff"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/cl-html-diff
	doins -r diff.text
}
