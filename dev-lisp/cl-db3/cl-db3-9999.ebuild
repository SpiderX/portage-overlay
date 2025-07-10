# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp lib to read dbf files version 3"
HOMEPAGE="https://github.com/dimitri/cl-db3"
EGIT_REPO_URI="https://github.com/dimitri/${PN}.git"

LICENSE="WTFPL-2"
SLOT="0"

BDEPEND="dev-lisp/asdf"
