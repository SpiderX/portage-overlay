# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="conduit conduit-async conduit-lwt conduit-lwt-unix conduit-mirage"

inherit dune

DESCRIPTION="A network connection establishment library"
HOMEPAGE="https://github.com/mirage/ocaml-conduit"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

# dev-ml/async_ssl: https://github.com/janestreet/async_ssl/issues/42
RDEPEND="dev-ml/astring:0=
	dev-ml/async:0=[ocamlopt?]
	dev-ml/ca-certs:0=[ocamlopt?]
	dev-ml/ca-certs-nss:0=[ocamlopt?]
	dev-ml/core:0=[ocamlopt?]
	dev-ml/cstruct:0=[ocamlopt?]
	dev-ml/dns:0=[ocamlopt?]
	dev-ml/ipaddr:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]
	dev-ml/mirage-crypto:0=[ocamlopt?]
	dev-ml/mirage-flow:0=[ocamlopt?]
	dev-ml/mirage-mtime:0=[ocamlopt?]
	dev-ml/mirage-ptime:0=[ocamlopt?]
	dev-ml/mirage-sleep:0=[ocamlopt?]
	dev-ml/ppx_here:0=[ocamlopt?]
	dev-ml/ppx_sexp_conv:0=[ocamlopt?]
	dev-ml/sexplib0:0=[ocamlopt?]
	dev-ml/tcpip:0=[ocamlopt?]
	dev-ml/tls:0=[ocamlopt?]
	dev-ml/uri[ocamlopt?]
	dev-ml/vchan:0=[ocamlopt?]
	dev-ml/xenstore:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/lwt_log
		dev-ml/lwt_ssl
		dev-ml/ocaml-ssl )"
