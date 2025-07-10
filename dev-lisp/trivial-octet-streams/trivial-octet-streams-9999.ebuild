# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A Common Lisp library for octet input and output streams"
HOMEPAGE="https://github.com/sharplispers/trivial-octet-streams"
EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-lisp/asdf"
