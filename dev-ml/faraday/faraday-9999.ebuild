# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="faraday faraday-async faraday-lwt faraday-lwt-unix"

inherit dune git-r3

DESCRIPTION="Serialization library built for speed and memory efficiency"
HOMEPAGE="https://github.com/inhabitedtype/faraday"
EGIT_REPO_URI="https://github.com/inhabitedtype/${PN}.git"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/async:0=[ocamlopt?]
	dev-ml/base:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/core:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
