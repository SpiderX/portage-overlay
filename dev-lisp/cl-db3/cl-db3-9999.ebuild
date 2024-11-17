# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dimitri/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp lib to read dbf files version 3"
HOMEPAGE="https://github.com/dimitri/cl-db3"

LICENSE="WTFPL-2"
SLOT="0"

BDEPEND="dev-lisp/asdf"
