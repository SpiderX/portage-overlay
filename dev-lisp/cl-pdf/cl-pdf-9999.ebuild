# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mbattyani/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Cross-platform Common Lisp library for generating PDF files"
HOMEPAGE="https://github.com/mbattyani/cl-pdf"

LICENSE="BSD-2"
SLOT="0"

RDEPEND="dev-lisp/iterate
	dev-lisp/salza2
	dev-lisp/uiop
	dev-lisp/zpb-ttf"
BDEPEND="dev-lisp/asdf"

PATCHES=( "${FILESDIR}/${PN}"-20230620-no-bundled-libs.patch )

src_prepare() {
	default

	# remove non supported implementation
	rm -rf C{CL,MUCL} || die "rm failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/fonts/afm
	doins -r afm/*.afm
}
