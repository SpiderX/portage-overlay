# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3f1de416f7f40a39c47f08335c710a884ece36b3"

DESCRIPTION="ASDF extension to provide support for file-local variables"
HOMEPAGE="https://github.com/didierverna/asdf-flv"
SRC_URI="https://github.com/didierverna/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="FSFAP"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"

src_prepare() {
	default

	mv {net.didierverna.,}asdf-flv.asd || die "mv failed"
	sed -i -e 's/net\.didierverna\.//g' asdf-flv.asd asdf-flv.lisp \
		package.lisp || die "sed failed"
}
