# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An Async-pipe-based interface with OpenSSL"
HOMEPAGE="https://github.com/janestreet/async_ssl"
SRC_URI="https://github.com/janestreet/${PN}/archive/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-libs/openssl:0=
	dev-ml/async:0=[ocamlopt?]
	dev-ml/base:0=[ocamlopt?]
	dev-ml/core:0=[ocamlopt?]
	dev-ml/ocaml-ctypes:0=[ocamlopt?]
	dev-ml/ppx_jane:0=[ocamlopt?]
	dev-ml/ppx_optcomp:0=[ocamlopt?]
	dev-ml/stdio:0=[ocamlopt?]"
BDEPEND="dev-ml/dune-configurator"
