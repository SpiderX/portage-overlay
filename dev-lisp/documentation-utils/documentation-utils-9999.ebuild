# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3 optfeature

DESCRIPTION="A few simple tools to help you with documenting your library"
HOMEPAGE="https://github.com/Shinmera/documentation-utils"
EGIT_REPO_URI="https://github.com/Shinmera/${PN}.git"

LICENSE="ZLIB"
SLOT="0"

RDEPEND="dev-lisp/trivial-indent"
BDEPEND="dev-lisp/asdf"

pkg_postinst() {
	# break circular dependency via optfeature
	optfeature "integration with multilang" dev-lisp/multilang-documentation
}
