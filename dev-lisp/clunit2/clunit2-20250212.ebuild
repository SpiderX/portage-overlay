# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="dd654e199aa3cbbdbcb0c2d8e1d240745bff75e8"

DESCRIPTION="Common Lisp unit testing framework"
HOMEPAGE="https://codeberg.org/cage/clunit2"
SRC_URI="https://codeberg.org/cage/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
