# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib

DESCRIPTION="Modules for OCaml application-level Internet protocols"
HOMEPAGE="http://projects.camlcity.org/projects/ocamlnet.html"
SRC_URI="http://download.camlcity.org/download/${P}.tar.gz"

LICENSE="ZLIB GPL-2+"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gtk kerberos tk httpd +ocamlopt +pcre ssl zip"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	gtk? ( dev-ml/lablgtk:2 )
	kerberos? ( virtual/krb5 )
	pcre? ( dev-ml/pcre-ocaml:= )
	tk? ( dev-ml/labltk:= )
	ssl? ( net-libs/gnutls:= )
	zip? ( dev-ml/camlzip:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	virtual/pkgconfig"

src_configure() {
	./configure \
		-bindir /usr/bin \
		-datadir /usr/share/"${PN}" \
		"$(use_enable gtk gtk2)" \
		"$(use_enable httpd nethttpd)" \
		"$(use_enable kerberos gssapi)" \
		"$(use_enable pcre pcre)" \
		"$(use_enable ssl gnutls)" \
		"$(use_enable tk tcl)" \
		"$(use_enable zip zip)" \
		|| die "Error : econf failed!"
}

src_compile() {
	emake -j1 all
	use ocamlopt && emake -j1 opt
}

src_install() {
	einstalldocs
	findlib_src_install
}
