# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COMMIT="c83b412cc5e7e310ad9b2dea76495145994f238f"

DESCRIPTION="Python string escaping for OCaml"
HOMEPAGE="https://github.com/reynir/python-str-repr"
SRC_URI="https://github.com/reynir/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/py:0=[ocamlopt?]
	dev-ml/uucp:0=
	dev-ml/uutf:0=[ocamlopt?]"
BDEPEND="test? ( dev-ml/alcotest
		dev-ml/qcheck )"

src_prepare() {
	default

	# disable not supported test
	sed -i '/name test_py_python_str_repr/a\\ (enabled_if false)' test/dune \
		|| die "sed failed for dune"
}
