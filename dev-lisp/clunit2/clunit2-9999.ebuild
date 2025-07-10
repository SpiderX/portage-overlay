# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp unit testing framework"
HOMEPAGE="https://codeberg.org/cage/clunit2"
EGIT_REPO_URI="https://codeberg.org/cage/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
