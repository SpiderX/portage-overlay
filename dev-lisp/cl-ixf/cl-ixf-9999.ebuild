# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dimitri/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Tools to handle IBM PC version of IXF file format"
HOMEPAGE="https://github.com/dimitri/cl-ixf"

LICENSE="WTFPL-2"
SLOT="0"

RDEPEND="dev-lisp/alexandria
	dev-lisp/babel
	dev-lisp/cl-ppcre
	dev-lisp/ieee-floats
	dev-lisp/local-time
	dev-lisp/md5
	dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf"
