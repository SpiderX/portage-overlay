# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Shinmera/${PN}.git"

inherit common-lisp-3 git-r3 optfeature

COMMIT="0196f6ce6828a745121374c238972491074f5eb1"

DESCRIPTION="A few simple tools to help you with documenting your library"
HOMEPAGE="https://github.com/Shinmera/documentation-utils"

LICENSE="ZLIB"
SLOT="0"

RDEPEND="dev-lisp/trivial-indent"
BDEPEND="dev-lisp/asdf"

pkg_postinst() {
	# break circular dependency via optfeature
	optfeature "integration with multilang" dev-lisp/multilang-documentation
}
