# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/didierverna/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="ASDF extension to provide support for file-local variables"
HOMEPAGE="https://github.com/didierverna/asdf-flv"

LICENSE="FSFAP"
SLOT="0"

BDEPEND="dev-lisp/asdf"

src_prepare() {
	default

	mv {net.didierverna.,}asdf-flv.asd || die "mv failed"
	sed -i -e 's/net\.didierverna\.//g' asdf-flv.asd asdf-flv.lisp \
		package.lisp || die "sed failed"
}
