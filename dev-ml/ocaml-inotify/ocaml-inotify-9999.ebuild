# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit git-r3 oasis

DESCRIPTION="OCaml bindings to inotify"
HOMEPAGE="https://github.com/whitequark/ocaml-inotify"
EGIT_REPO_URI="https://github.com/whitequark/${PN}.git"
SRC_URI=""

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="debug doc lwt +ocamlopt profiling test"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]
	lwt? ( dev-ml/lwt:= )"
DEPEND="${RDEPEND}
	dev-ml/findlib
	test? ( dev-ml/ocaml-fileutils:= )"

src_configure() {
	oasis_configure_opts="$(use_enable debug)" "$(use_enable doc docs)" \
		"$(use_enable lwt)" "$(use_enable profiling profile)" "$(use_enable test tests)"
	oasis_src_configure
}
