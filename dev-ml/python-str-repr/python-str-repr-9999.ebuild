# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune git-r3

DESCRIPTION="Python string escaping for OCaml"
HOMEPAGE="https://github.com/reynir/python-str-repr"
EGIT_REPO_URI="https://github.com/reynir/${PN}.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
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
