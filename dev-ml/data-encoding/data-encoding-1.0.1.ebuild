# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="data-encoding json-data-encoding json-data-encoding-browser
	json-data-encoding-bson"

inherit dune

COMMIT="d5db30a38ac276a8d0da30fe78e32ab2b8f796ae"

DESCRIPTION="Type-safe encoding to and decoding from JSON"
HOMEPAGE="https://gitlab.com/nomadic-labs/data-encoding/"
SRC_URI="https://gitlab.com/nomadic-labs/${PN}/-/archive/v${PV}/${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}-${COMMIT}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/bigstringaf[ocamlopt?]
	dev-ml/either:0=[ocamlopt?]
	dev-ml/ezjsonm:0=[ocamlopt?]
	dev-ml/hex:0=[ocamlopt?]
	dev-ml/js_of_ocaml:0=[ocamlopt?]
	dev-ml/ocplib-endian:0=[ocamlopt?]
	dev-ml/ppx_expect:0=[ocamlopt?]
	dev-ml/ppx_hash:0=[ocamlopt?]
	dev-ml/uri[ocamlopt?]
	dev-ml/zarith[ocamlopt?]
	dev-ml/zarith_stubs_js:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/crowbar
		dev-ml/md2mld )"

PATCHES=( "${FILESDIR}/${PN}"-1.0.1-test.patch )
