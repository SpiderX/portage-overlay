# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="en it nl sv"
PLOCALE_BACKUP="en"

inherit ecm git-r3 plocale

DESCRIPTION="Plasma widget for play ambient noise"
HOMEPAGE="https://github.com//plasma-applet-ambientnoise"
EGIT_REPO_URI="https://github.com/m-pilia/${PN}.git"

LICENSE="GPL-3"
SLOT="6"

RDEPEND="dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	kde-frameworks/kirigami:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	my_rm_loc() {
		rm translations/po/plasma_applet_org.kde.plasma.ambientnoise_"${1}".po \
			|| die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLOCALE_INSTALL_DIR="/usr/share/locale"
	)
	cmake_src_configure
}
