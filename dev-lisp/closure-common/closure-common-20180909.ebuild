# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="e3c5f5f454b72b01b89115e581c3c52a7e201e5c"

DESCRIPTION="An internal helper library for the closure web browser"
HOMEPAGE="https://github.com/sharplispers/closure-common"
SRC_URI="https://github.com/sharplispers/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lisp/babel
	dev-lisp/trivial-gray-streams"
BDEPEND="dev-lisp/asdf"
