# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A drop-in replacement for cl:documentation"
HOMEPAGE="https://github.com/Shinmera/multilang-documentation"
EGIT_REPO_URI="https://github.com/Shinmera/${PN}.git"

LICENSE="ZLIB"
SLOT="0"

RDEPEND="dev-lisp/documentation-utils
	dev-lisp/language-codes
	dev-lisp/system-locale"
BDEPEND="dev-lisp/asdf"
