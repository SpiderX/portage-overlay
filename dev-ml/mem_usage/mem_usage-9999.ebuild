# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Cross-platform memory usage information"
HOMEPAGE="https://github.com/savonet/ocaml-mem_usage"
EGIT_REPO_URI="https://github.com/savonet/ocaml-mem_usage.git"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="+ocamlopt"
