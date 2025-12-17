# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Map filenames to common MIME types"
HOMEPAGE="https://github.com/mirage/ocaml-magic-mime"
EGIT_REPO_URI="https://github.com/mirage/ocaml-magic-mime.git"

LICENSE="ISC"
SLOT="0/${PV}"
IUSE="+ocamlopt"
