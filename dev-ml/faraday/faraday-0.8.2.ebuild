# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="faraday faraday-async faraday-lwt faraday-lwt-unix"

inherit dune

DESCRIPTION="Serialization library built for speed and memory efficiency"
HOMEPAGE="https://github.com/inhabitedtype/faraday"
SRC_URI="https://github.com/inhabitedtype/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/async:0=[ocamlopt?]
	dev-ml/base:0=[ocamlopt?]
	dev-ml/bigstringaf:0=[ocamlopt?]
	dev-ml/core:0=[ocamlopt?]
	dev-ml/lwt:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest )"
