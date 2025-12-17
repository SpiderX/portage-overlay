# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Implementation of quoted-printable encoder/decoder from RFC2045"
HOMEPAGE="https://github.com/mirage/pecu"
EGIT_REPO_URI="https://github.com/mirage/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-ml/alcotest
		dev-ml/astring
		dev-ml/crowbar
		dev-ml/fmt )"
