# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="940468f477d708511a0fd5c36ac346cd3ad67880"

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
