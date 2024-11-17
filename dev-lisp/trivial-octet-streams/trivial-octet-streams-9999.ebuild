# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp library for octet input and output streams"
HOMEPAGE="https://github.com/sharplispers/trivial-octet-streams"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-lisp/asdf"
