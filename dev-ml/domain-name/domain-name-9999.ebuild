# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="RFC 1035 Internet domain names"
HOMEPAGE="https://github.com/hannesm/domain-name"
EGIT_REPO_URI="https://github.com/ocaml-multicore/${PN}.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest )"
