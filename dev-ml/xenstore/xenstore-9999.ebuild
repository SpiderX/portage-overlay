# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Xenstore protocol in pure OCam"
HOMEPAGE="https://github.com/mirage/ocaml-xenstore"
EGIT_REPO_URI="https://github.com/mirage/ocaml-xenstore.git"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/ounit2 )"
