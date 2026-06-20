# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A few utility functions from the LispWorks library"
HOMEPAGE="https://codeberg.org/pcostanza/lw-compat"
EGIT_REPO_URI="https://codeberg.org/pcostanza/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
