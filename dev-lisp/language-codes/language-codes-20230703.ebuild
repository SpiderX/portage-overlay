# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="358c1de9f2e0d6501aed8cb03030311a32849e0e"

DESCRIPTION="A simple library mapping ISO language codes to language names"
HOMEPAGE="https://github.com/Shinmera/language-codes"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/documentation-utils"
BDEPEND="dev-lisp/asdf"
