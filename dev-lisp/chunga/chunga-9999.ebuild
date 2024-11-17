# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/edicl/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Portable chunked streams for Common Lisp"
HOMEPAGE="https://github.com/edicl/chunga"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-lisp/trivial-gray-streams"
