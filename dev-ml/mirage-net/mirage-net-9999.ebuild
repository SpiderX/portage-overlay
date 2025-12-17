# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Network signatures for MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-net"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]"
