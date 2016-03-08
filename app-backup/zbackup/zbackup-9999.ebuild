# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit cmake-utils git-r3

DESCRIPTION="A versatile deduplicating backup tool"
HOMEPAGE="http://zbackup.org/ https://github.com/${PN}/${PN}"
EGIT_REPO_URI="git://github.com/${PN}/${PN}.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"

DEPEND="app-arch/lzma
	dev-libs/lzo
	dev-libs/openssl:0=
	dev-libs/protobuf
	sys-libs/zlib
	sys-libs/libunwind"
RDEPEND="${DEPEND}"
