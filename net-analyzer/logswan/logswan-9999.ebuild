# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/fcambus/${PN}.git"

inherit cmake-utils git-r3

DESCRIPTION="Web log analyzer using probabilistic data structures"
HOMEPAGE="https://github.com/fcambus/logswan"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/geoip
	dev-libs/jansson"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGEOIPDIR="$(pkg-config --variable=databasedir geoip)"
	)
	cmake-utils_src_configure
}
