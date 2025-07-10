# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp Metaobject Protocol compatibility layer"
HOMEPAGE="https://closer.common-lisp.dev/closer-mop.html"
EGIT_REPO_URI="https://github.com/pcostanza/${PN}.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lisp/asdf"
