# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Shinmera/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Allow indentation hints for SWANK"
HOMEPAGE="https://github.com/Shinmera/trivial-indent"

LICENSE="ZLIB"
SLOT="0"
