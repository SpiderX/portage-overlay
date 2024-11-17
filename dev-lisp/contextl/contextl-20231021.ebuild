# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3d5fbff50c686f0b89b9ca7fdebfe056343dc366"

DESCRIPTION="CLOS extension for Context-oriented Programming"
HOMEPAGE="https://github.com/pcostanza/contextl"
SRC_URI="https://github.com/pcostanza/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
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
	pushd test || die "pushd failed"
	./sbcl-runall || die "test failed"
	popd || die "popd failed"
}
