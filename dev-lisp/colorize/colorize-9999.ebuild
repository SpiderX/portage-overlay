# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/kingcons/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A Syntax Highlighting library"
HOMEPAGE="https://github.com/kingcons/colorize"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-lisp/alexandria
	dev-lisp/html-encode
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf"
