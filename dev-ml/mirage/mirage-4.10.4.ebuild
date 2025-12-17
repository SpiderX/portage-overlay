# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="mirage mirage-runtime"

inherit dune edo

DESCRIPTION="The MirageOS library operating system"
HOMEPAGE="https://github.com/mirage/mirage"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-ml/astring:0=
	dev-ml/bos:0=
	>=dev-ml/cmdliner-2.0.0:0=[ocamlopt?]
	dev-ml/emile:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/fpath:0=
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/opam-monorepo:0=[ocamlopt?]
	dev-ml/rresult:0=
	dev-ml/uri[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator
	test? ( dev-ml/alcotest )"

src_test() {
	edo opam init -n --no-opamrc --disable-sandboxing
	# remove integration tests
	edo rm -rf test/{functoria/e2e,mirage/random}
	dune_src_test
}
