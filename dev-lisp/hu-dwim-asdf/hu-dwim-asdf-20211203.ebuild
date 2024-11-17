# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="4796e2833ad39f3e375a99c632de9f5973fd353f"
MY_PN="${PN//-/.}"

DESCRIPTION="Common Lisp extensions to ASDF"
HOMEPAGE="https://github.com/hu-dwim/hu.dwim.asdf"
SRC_URI="https://github.com/hu-dwim/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-lisp/uiop
	doc? ( dev-lisp/hu-dwim-presentation )"
BDEPEND="dev-lisp/asdf"
