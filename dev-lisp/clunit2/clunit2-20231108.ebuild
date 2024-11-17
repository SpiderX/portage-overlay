# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="b24c56851ee6ee6c4a9dc3725a634c06b604f207"

DESCRIPTION="Common Lisp unit testing framework"
HOMEPAGE="https://codeberg.org/cage/clunit2"
SRC_URI="https://codeberg.org/cage/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
