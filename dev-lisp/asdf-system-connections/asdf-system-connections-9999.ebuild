# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Auto-loading of Common Lisp systems"
HOMEPAGE="https://github.com/lisp-maintainers/asdf-system-connections"
EGIT_REPO_URI="https://github.com/lisp-maintainers/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
