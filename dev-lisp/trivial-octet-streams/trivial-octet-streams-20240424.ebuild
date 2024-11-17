# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="71b00632c569618863376dd0cb985f6868b523b0"

DESCRIPTION="A Common Lisp library for octet input and output streams"
HOMEPAGE="https://github.com/sharplispers/trivial-octet-streams"
SRC_URI="https://github.com/sharplispers/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lisp/asdf"
