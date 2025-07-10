# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A collection of utilities to destructure lambda forms"
HOMEPAGE="https://github.com/Shinmera/form-fiddle"
EGIT_REPO_URI="https://github.com/Shinmera/${PN}.git"

LICENSE="ZLIB"
SLOT="0"

RDEPEND="dev-lisp/documentation-utils"
BDEPEND="dev-lisp/asdf"
