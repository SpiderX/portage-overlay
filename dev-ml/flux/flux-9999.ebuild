# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="flux fluxt"

inherit dune git-r3

DESCRIPTION="A streaming library for Miou"
HOMEPAGE="https://github.com/robur-coop/flux"
EGIT_REPO_URI="https://github.com/robur-coop/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/angstrom:=[ocamlopt?]
	dev-ml/bstr:0=[ocamlopt?]
	dev-ml/decompress:0=[ocamlopt?]
	dev-ml/digestif:0=[ocamlopt?]
	dev-ml/miou:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/tar:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
