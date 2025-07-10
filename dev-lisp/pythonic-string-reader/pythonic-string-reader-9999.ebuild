# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A simple and unintrusive read table modification"
HOMEPAGE="https://github.com/smithzvk/pythonic-string-reader"
EGIT_REPO_URI="https://github.com/smithzvk/${PN}.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-lisp/asdf"
