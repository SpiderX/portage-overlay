# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="ezcurl ezcurl-lwt"

inherit dune git-r3

DESCRIPTION="A simple wrapper around OCurl"
HOMEPAGE="https://github.com/c-cube/ezcurl"
EGIT_REPO_URI="https://github.com/c-cube/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-ml/lwt:0=[ocamlopt?]
	dev-ml/ocurl:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/mdx
		dev-ml/tiny_httpd )"
