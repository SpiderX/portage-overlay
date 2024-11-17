# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://codeberg.org/cage/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp unit testing framework"
HOMEPAGE="https://codeberg.org/cage/clunit2"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
