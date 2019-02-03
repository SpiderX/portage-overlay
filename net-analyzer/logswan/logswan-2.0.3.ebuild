# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=ninja

inherit cmake-utils

DESCRIPTION="Web log analyzer using probabilistic data structures"
HOMEPAGE="https://github.com/fcambus/logswan"
SRC_URI="https://github.com/fcambus/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/jansson
	dev-libs/libmaxminddb:="
DEPEND="${RDEPEND}
	dev-libs/geoip"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGEOIP2DIR="$(pkg-config --variable=databasedir geoip)"
	)
	cmake-utils_src_configure
}
