# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

DESCRIPTION="Common Lisp Metaobject Protocol compatibility layer"
HOMEPAGE="https://closer.common-lisp.dev/closer-mop.html"
SRC_URI="https://github.com/pcostanza/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
