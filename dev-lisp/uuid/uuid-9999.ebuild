# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp implementation of UUIDs according to RFC4122"
HOMEPAGE="https://github.com/dardoria/uuid"
EGIT_REPO_URI="https://github.com/dardoria/${PN}.git"

LICENSE="LLGPL-2.1"
SLOT="0"

RDEPEND="dev-lisp/ironclad
	dev-lisp/trivial-utf8"
BDEPEND="dev-lisp/asdf"
