# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="AirPods libreated from Apple's ecosystem"
HOMEPAGE="https://github.com/kavishdevar/librepods"
EGIT_REPO_URI="https://github.com/kavishdevar/${PN}.git"
S="${WORKDIR}/${P}/linux"

LICENSE="AGPL-3"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[dbus,widgets]
	dev-qt/qtconnectivity:6[bluetooth]
	dev-qt/qtdeclarative:6[widgets]
	dev-qt/qtmultimedia:6[ffmpeg]"
DEPEND="dev-libs/openssl:="
