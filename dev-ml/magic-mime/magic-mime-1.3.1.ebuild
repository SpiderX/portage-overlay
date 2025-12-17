# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Map filenames to common MIME types"
HOMEPAGE="https://github.com/mirage/ocaml-magic-mime"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/v${PV}/${P}.tbz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"
