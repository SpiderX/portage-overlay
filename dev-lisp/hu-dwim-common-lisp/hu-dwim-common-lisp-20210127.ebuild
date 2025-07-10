# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="90558195773383142a57a16687d5e7f4adea6418"
MY_PN="${PN//-/.}"

DESCRIPTION="A redefinition of the standard Common Lisp package"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.common-lisp"
SRC_URI="https://github.com/hu-dwim/${MY_PN//.lisp/-lisp}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN//.lisp/-lisp}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-lisp/hu-dwim-asdf
	doc? ( dev-lisp/hu-dwim-presentation )"
