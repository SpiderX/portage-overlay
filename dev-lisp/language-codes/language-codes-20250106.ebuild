# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="acf4468ea6ed74e01ef947ce8fbd6e5a7b2d641c"

DESCRIPTION="A simple library mapping ISO language codes to language names"
HOMEPAGE="https://github.com/Shinmera/language-codes"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/documentation-utils"
BDEPEND="dev-lisp/asdf"
