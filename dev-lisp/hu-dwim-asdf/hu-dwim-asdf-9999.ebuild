# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp extensions to ASDF"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.asdf"
EGIT_REPO_URI="https://github.com/hu-dwim/hu.dwim.asdf.git"

LICENSE="MIT-0"
SLOT="0"
IUSE="doc"

RDEPEND="dev-lisp/uiop
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf"
