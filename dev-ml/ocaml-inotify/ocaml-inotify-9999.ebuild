# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="inotify"
EGIT_REPO_URI="https://github.com/whitequark/${PN}.git"

inherit dune git-r3

DESCRIPTION="OCaml bindings for inotify"
HOMEPAGE="https://github.com/whitequark/ocaml-inotify"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+ocamlopt"

RDEPEND="dev-ml/lwt:=[ocamlopt?]"

src_prepare() {
	default

	rm LICENSE.txt || die "rm failed"

	# Specify version
	sed -i "/^(name inotify)/i(version ${PV})" dune-project \
		|| die "sed failed"
}
