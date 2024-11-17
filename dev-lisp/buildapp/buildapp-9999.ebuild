# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/xach/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Buildapp makes it easy to build application executables with SBCL"
HOMEPAGE="https://github.com/xach/buildapp"

LICENSE="BSD"
SLOT="0"
RESTRICT="strip"

BDEPEND="dev-lisp/asdf"

QA_FLAGS_IGNORED="/usr/bin/buildapp"

src_compile() {
	emake
}

src_install() {
	common-lisp-3_src_install
	dobin buildapp
}