# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 edo

COMMIT="3d5fbff50c686f0b89b9ca7fdebfe056343dc366"

DESCRIPTION="CLOS extension for Context-oriented Programming"
HOMEPAGE="https://codeberg.org/pcostanza/contextl"
SRC_URI="https://codeberg.org/pcostanza/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lisp/closer-mop
	dev-lisp/lw-compat"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/sbcl:* )"

src_test() {
	edo pushd test
	edo ./sbcl-runall
	edo popd
}
