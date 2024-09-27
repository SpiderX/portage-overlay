# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="Linux multi-touch gesture recognizer"
HOMEPAGE="https://github.com/JoseExposito/touchegg"
SRC_URI="https://github.com/JoseExposito/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk systemd"

RDEPEND="dev-libs/libinput:=
	dev-libs/pugixml
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXrandr
	x11-libs/libXi
	dev-libs/glib:2
	virtual/libudev:=
	gtk? ( x11-libs/gtk+:3 )
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

src_configure() {
	local mycmakeargs=(
		-DAUTO_COLORS="$(usex gtk)"
		-DUSE_SYSTEMD="$(usex systemd)"
	)
	cmake_src_configure
}

src_install() {
	newinitd "${FILESDIR}"/touchegg.initd touchegg
	newconfd "${FILESDIR}"/touchegg.confd touchegg
	systemd_dounit "${FILESDIR}"/touchegg.service

	cmake_src_install
}
