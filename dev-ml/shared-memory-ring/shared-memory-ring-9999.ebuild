# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="shared-memory-ring shared-memory-ring-lwt"

inherit dune

DESCRIPTION="Xen-style shared memory rings"
HOMEPAGE="https://github.com/mirage/shared-memory-ring"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"
RESTRICT="test" # dev-ml/ounit2 doesn't have ounit

RDEPEND="dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/lwt-dllist:0=[ocamlopt?]"
