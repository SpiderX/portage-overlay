# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit findlib

DESCRIPTION="OCaml syslog client functions"
HOMEPAGE="http://opam.ocaml.org/packages/syslog https://github.com/ocaml/opam-repository/"
SRC_URI="http://deb.debian.org/debian/pool/main/s/syslog-ocaml/syslog-ocaml_${PV}.orig.tar.gz"
LICENSE="CC0-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+camlp4 +ocamlopt"
RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	camlp4? ( dev-ml/camlp4:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib"
S="${WORKDIR}/syslog-${PV}"

src_compile() {
	export USE_CAMLP4=$(usex camlp4 yes '')
	emake $(usex ocamlopt reallyall all)
}

src_install() {
	findlib_src_install
}
