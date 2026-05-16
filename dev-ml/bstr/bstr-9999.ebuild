# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="bin bstr slice"

inherit dune git-r3

DESCRIPTION="A synthetic library for bigstrings"
HOMEPAGE="https://github.com/robur-coop/bstr"
EGIT_REPO_URI="https://github.com/robur-coop/${PN}.git"

LICENSE="MIT"
SLOT="0/${PV}"
IUSE="+ocamlopt"
