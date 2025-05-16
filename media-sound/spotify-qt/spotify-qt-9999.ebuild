# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="Lightweight Spotify client using Qt"
HOMEPAGE="https://github.com/kraxarn/spotify-qt"
EGIT_REPO_URI="https://github.com/kraxarn/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-qt/qtbase:6[dbus,network,widgets]
	dev-qt/qtsvg:6"
