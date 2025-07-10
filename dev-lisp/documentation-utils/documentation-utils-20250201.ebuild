# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 optfeature

COMMIT="0665d6e43d135d02658292ac1dae3b17ff426889"

DESCRIPTION="A few simple tools to help you with documenting your library"
HOMEPAGE="https://github.com/Shinmera/documentation-utils"
SRC_URI="https://github.com/Shinmera/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/trivial-indent"
BDEPEND="dev-lisp/asdf"

pkg_postinst() {
	# break circular dependency via optfeature
	optfeature "integration with multilang" dev-lisp/multilang-documentation
}
