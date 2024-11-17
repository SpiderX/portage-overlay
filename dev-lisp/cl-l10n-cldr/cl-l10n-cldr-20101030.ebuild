# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="CLDR files for cl-l10n package"
HOMEPAGE="https://gitlab.common-lisp.net/cl-l10n/cl-l10n-cldr"
SRC_URI="https://gitlab.common-lisp.net/cl-l10n/${PN}/-/archive/master/${PN}-master.tar.bz2"
S="${WORKDIR}/${PN}-master"

LICENSE="Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/cl-l10n-cldr
	doins -r common test
}
