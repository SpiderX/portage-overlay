# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="b7f42ddbb33f5011cbc3ca777d4be060a9823738"

DESCRIPTION="A library to retrieve the system's configured locale and language"
HOMEPAGE="https://github.com/Shinmera/system-locale"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/cffi
	dev-lisp/documentation-utils"
BDEPEND="dev-lisp/asdf"
