# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DUNE_PKG_NAME="dune-configurator"

inherit dune edo

DESCRIPTION="Helper library for gathering system configuration"
HOMEPAGE="https://github.com/ocaml/dune"
SRC_URI="https://github.com/ocaml/dune/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dune-${PV}"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt test"
RESTRICT="test" # tests in main dune package

DEPEND="dev-ml/csexp:0=[ocamlopt?]"
RDEPEND="${DEPEND}
	>=dev-ml/dune-3.20:0=
	dev-ml/pp:=[ocamlopt?]"
BDEPEND="test? ( dev-ml/utop )"

src_prepare() {
	default

	# don't use vendored libs
	edo rm -rf vendor/csexp
	edo rm -rf vendor/pp
}

src_configure() { :; }

src_compile() {
	dune-compile ${DUNE_PKG_NAME}
}
