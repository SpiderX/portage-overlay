# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit cmake-utils

DESCRIPTION="A versatile deduplicating backup tool"
HOMEPAGE="http://zbackup.org/ https://github.com/${PN}/${PN}"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="app-arch/lzma
	dev-libs/lzo
	dev-libs/openssl:0=
	dev-libs/protobuf
	sys-libs/zlib"
RDEPEND="${DEPEND}"
