# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Fixed-point mp3 encoding library"
HOMEPAGE="https://github.com/toots/shine"
SRC_URI="https://github.com/toots/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( ChangeLog )

src_prepare() {
	default
	eautoreconf
}
