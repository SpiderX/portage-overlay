# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="MirageOS signatures for key/value devices"
HOMEPAGE="https://github.com/mirage/mirage-kv"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/fmt:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
