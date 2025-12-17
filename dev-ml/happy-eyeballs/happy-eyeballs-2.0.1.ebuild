# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# happy-eyeballs-lwt needs dns, which needs happy-eyeballs-lwt
DUNE_PKG_NAME="happy-eyeballs happy-eyeballs-miou-unix happy-eyeballs-mirage"

inherit dune

DESCRIPTION="Connecting to a remote host via IP version 4 or 6"
HOMEPAGE="https://github.com/robur-coop/happy-eyeballs"
SRC_URI="https://github.com/robur-coop/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/domain-name:0=[ocamlopt?]
	dev-ml/duration:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/miou:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/tcpip:0=[ocamlopt?]"

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
