# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="cohttp cohttp-async cohttp-bench cohttp-curl cohttp-curl-async
	cohttp-curl-lwt cohttp-eio cohttp-lwt cohttp-lwt-jsoo cohttp-lwt-unix
	cohttp-mirage cohttp-server-lwt-unix cohttp-top http"

inherit dune edo git-r3

DESCRIPTION="OCaml library for HTTP clients and servers"
HOMEPAGE="https://github.com/mirage/ocaml-cohttp"
EGIT_REPO_URI="https://github.com/mirage/ocaml-cohttp.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/astring:0=
	dev-ml/async:0=[ocamlopt?]
	dev-ml/async_kernel:0=[ocamlopt?]
	dev-ml/async_unix:0=[ocamlopt?]
	dev-ml/base:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/conduit:0=[ocamlopt?]
	dev-ml/core:0=[ocamlopt?]
	dev-ml/core_bench:0=[ocamlopt?]
	dev-ml/core_unix:0=[ocamlopt?]
	dev-ml/crowbar:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/ocurl:0=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/fmt:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/js_of_ocaml:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/magic-mime:0=[ocamlopt?]
	dev-ml/mirage-channel:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-kv:0=[ocamlopt?]
	dev-ml/ocaml-base64:0=[ocamlopt?]
	dev-ml/ptime:0=[ocamlopt?]
	dev-ml/ppx_expect:0=[ocamlopt?]
	dev-ml/ppx_sexp_conv:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/sexplib0:0=[ocamlopt?]
	dev-ml/stringext[ocamlopt?]
	dev-ml/uri[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/base_quickcheck
		dev-ml/ca-certs
		dev-ml/core_kernel
		dev-ml/crowbar
		dev-ml/digestif
		dev-ml/mdx
		dev-ml/mirage-crypto
		dev-ml/ounit2
		dev-ml/ppx_assert
		dev-ml/ppx_compare
		dev-ml/ppx_expect
		dev-ml/ppx_here
		dev-ml/tls
		net-libs/nodejs )"

src_prepare() {
	default

	# remove fuzzers
	edo rm -rf http/fuzz
}
