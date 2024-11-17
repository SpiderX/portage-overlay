# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="3bd0dfdae8f83918fce6cb4a05826bd325da401d"

DESCRIPTION="A collection of utilities to destructure lambda forms"
HOMEPAGE="https://github.com/Shinmera/form-fiddle"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/documentation-utils"
BDEPEND="dev-lisp/asdf"
