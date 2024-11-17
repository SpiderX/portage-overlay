# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="9f085240febccccff99d9d3bb687fcaafffd3f5e"

DESCRIPTION="Auto-loading of Common Lisp systems"
HOMEPAGE="https://github.com/lisp-maintainers/asdf-system-connections"
SRC_URI="https://github.com/lisp-maintainers/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
