# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/smithzvk/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="A simple and unintrusive read table modification"
HOMEPAGE="https://github.com/smithzvk/pythonic-string-reader"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-lisp/asdf"
