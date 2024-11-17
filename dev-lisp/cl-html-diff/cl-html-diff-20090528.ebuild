# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="5a0b39d1c524278d6f60851d7786bb2585614310"

DESCRIPTION="A Common Lisp library for generating a human-readable diff"
HOMEPAGE="https://github.com/wiseman/cl-html-diff"
SRC_URI="https://github.com/wiseman/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/cl-html-diff
	doins -r diff.text
}
