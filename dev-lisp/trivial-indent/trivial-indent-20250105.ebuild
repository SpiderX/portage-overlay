# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="fc7380b0f5683a6f531150c4bfca724a621cfc0b"

DESCRIPTION="Allow indentation hints for SWANK"
HOMEPAGE="https://github.com/Shinmera/trivial-indent"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
