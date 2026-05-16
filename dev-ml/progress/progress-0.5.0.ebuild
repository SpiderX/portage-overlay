# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="progress terminal"

inherit dune

DESCRIPTION="Progress bar library for OCaml"
HOMEPAGE="https://github.com/CraigFe/progress"
SRC_URI="https://github.com/CraigFe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/fmt:0=[ocamlopt?]
	dev-ml/logs:0=[ocamlopt?]
	dev-ml/mtime:0=
	dev-ml/optint:0=[ocamlopt?]
	dev-ml/stdlib-shims:=[ocamlopt?]
	dev-ml/uucp:0=
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/astring )"
