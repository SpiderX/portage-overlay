# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2046

EAPI=8

# atdd needs dlang
# atds needs some java env tricks
DUNE_PKG_NAME="atd atdcpp atd-jsonlike atdpy atdgen atdgen-codec-runtime
	atdgen-runtime atdml atdts atd-yamlx"

PYTHON_COMPAT=( python3_{12..14} )

inherit dune java-pkg-opt-2 python-any-r1

DESCRIPTION="Static types for JSON APIs"
HOMEPAGE="https://github.com/ahrefs/atd"
SRC_URI="https://github.com/ahrefs/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="dev-ml/biniou:0=[ocamlopt?]
	dev-ml/cmdliner:0=[ocamlopt?]
	dev-ml/easy-format:0=[ocamlopt?]
	dev-ml/menhir:0=[ocamlopt?]
	dev-ml/re:0=[ocamlopt?]
	dev-ml/yamlx:0=[ocamlopt?]
	dev-ml/yojson:0=[ocamlopt?]
	java? ( virtual/jdk:17 )"
# atds needs dev-lang/scala-bin, scala needs jdk:17
BDEPEND="${PYTHON_DEPS}
	test? ( dev-libs/rapidjson
		dev-ml/alcotest
		dev-ml/testo
		dev-ml/qcheck
		$(python_gen_any_dep 'dev-python/flake8[${PYTHON_USEDEP}]
			dev-python/mypy[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]') )"

python_check_deps() {
	python_has_version "dev-python/flake8[${PYTHON_USEDEP}]" &&
	python_has_version "dev-python/mypy[${PYTHON_USEDEP}]" &&
	python_has_version "dev-python/pytest[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use java && java-pkg-opt-2_pkg_setup
	python-any-r1_pkg_setup
}

src_compile() {
	dune-compile $(usex java "${DUNE_PKG_NAME} atdj" "${DUNE_PKG_NAME}")
}

src_test() {
	dune-test $(usex java "${DUNE_PKG_NAME} atdj" "${DUNE_PKG_NAME}")
}

src_install() {
	dune-install $(usex java "${DUNE_PKG_NAME} atdj" "${DUNE_PKG_NAME}")
}
