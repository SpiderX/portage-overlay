# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="dc3fff9d4e04f1613227c25a290c8f34e9f8a311"

DESCRIPTION="Helps macro writers produce better errors for macro users"
HOMEPAGE="https://github.com/scymtym/trivial-with-current-source-form"
SRC_URI="https://github.com/scymtym/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/alexandria"

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/trivial-with-current-source-form
	doins version-string.sexp
}
