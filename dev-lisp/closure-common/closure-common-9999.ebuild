# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="An internal helper library for the closure web browser"
HOMEPAGE="https://github.com/sharplispers/closure-common"

LICENSE="LLGPL-2.1"
SLOT="0"

RDEPEND="dev-lisp/babel
	dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf"
