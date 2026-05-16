# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="tiny_httpd tiny_httpd_camlzip tiny_httpd_eio"

inherit dune git-r3

DESCRIPTION="Minimal HTTP server using good old threads"
HOMEPAGE="https://github.com/c-cube/tiny_httpd"
EGIT_REPO_URI="https://github.com/c-cube/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/camlzip:1=[ocamlopt?]
	dev-ml/eio:0=[ocamlopt?]
	dev-ml/hmap
	dev-ml/iostream:=[ocamlopt?]
	dev-ml/seq:=[ocamlopt?]
	dev-ml/result:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/logs
		dev-ml/ptime
		>=dev-ml/qcheck-0.91
		net-misc/curl )"
