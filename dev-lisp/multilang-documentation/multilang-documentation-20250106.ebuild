# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="178a2635c6a931062df4c12c2f3633fd83bb6bc6"

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
