# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="inotify"

inherit dune

DESCRIPTION="OCaml bindings for inotify"
HOMEPAGE="https://github.com/whitequark/ocaml-inotify"
SRC_URI="https://api.github.com/repos/whitequark/${PN}/tarball/b340204 -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-ml/lwt:=[ocamlopt?]"

S="${WORKDIR}/whitequark-${PN}-b340204"

src_prepare() {
	default

	rm LICENSE.txt || die "rm failed"

	# Specify version
	sed -i "/^(name inotify)/i(version ${PV})" dune-project \
		|| die "sed failed"
}
