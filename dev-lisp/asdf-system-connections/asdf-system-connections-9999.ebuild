# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/lisp-maintainers/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Auto-loading of Common Lisp systems"
HOMEPAGE="https://github.com/lisp-maintainers/asdf-system-connections"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
