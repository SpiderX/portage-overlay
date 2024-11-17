# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="ba1fbb104dedbdaddb1ef93d2e4da711bd96cd70"

DESCRIPTION="Common Lisp ABNF Parser Generator"
HOMEPAGE="https://github.com/dimitri/cl-abnf"
SRC_URI="https://github.com/dimitri/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/cl-ppcre
	dev-lisp/esrap"
BDEPEND="dev-lisp/asdf"
