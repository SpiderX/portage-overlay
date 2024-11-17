# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="aa0c7d14f59cbddcfcb6c6bedc3904fe95d654cf"

DESCRIPTION="A drop-in replacement for cl:documentation"
HOMEPAGE="https://github.com/Shinmera/multilang-documentation"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/documentation-utils
	dev-lisp/language-codes
	dev-lisp/system-locale"
BDEPEND="dev-lisp/asdf"
