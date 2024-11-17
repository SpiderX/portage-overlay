# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="b5d490f9c619a8e9ec9e43fe76892e27d3e0f9a8"

DESCRIPTION="Allow indentation hints for SWANK"
HOMEPAGE="https://github.com/Shinmera/trivial-indent"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
