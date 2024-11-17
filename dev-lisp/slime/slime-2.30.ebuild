# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="The Superior Lisp Interaction Mode for Emacs"
HOMEPAGE="https://github.com/slime/slime"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain GPL-2+ GPL-3+ LLGPL-2.1 ZLIB xref? ( xref.lisp )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xref"

BDEPEND="dev-lisp/asdf
	sys-apps/texinfo"

DOCS=( ) # collision with app-emacs/slime

src_prepare() {
	default

	# Remove xref.lisp (which is non-free) unless USE flag is set
	use xref || rm xref.lisp || die
}

src_test() {
	emake check
}
