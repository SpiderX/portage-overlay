# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/usocket/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A trivial networking library for Common Lisp"
HOMEPAGE="https://github.com/usocket/trivial-sockets"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
