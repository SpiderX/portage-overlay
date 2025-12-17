# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Xen core platform libraries for MirageOS"
HOMEPAGE="https://github.com/mirage/mirage-xen"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="dev-ml/bheap:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/io-page:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/lwt-dllist:0=[ocamlopt?]
	dev-ml/metrics:0=[ocamlopt?]
	dev-ml/mirage:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/shared-memory-ring:0=[ocamlopt?]
	dev-ml/xenstore:0=[ocamlopt?]"
