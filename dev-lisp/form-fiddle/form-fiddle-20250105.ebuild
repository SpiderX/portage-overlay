# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="fc4e7e607200356f4e665b9282e4125a3136a2e7"

DESCRIPTION="A collection of utilities to destructure lambda forms"
HOMEPAGE="https://github.com/Shinmera/form-fiddle"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/documentation-utils"
BDEPEND="dev-lisp/asdf"
