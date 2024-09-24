# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/kevinbburns/${PN}.git"

inherit ecm git-r3

DESCRIPTION="KDE Plasma6 Panel Widget for a Webview to Grammarly Editor"
HOMEPAGE="https://github.com/kevinbburns/com.kevinbburns.grammarly"

LICENSE="BSD"
SLOT="6"

RDEPEND="dev-qt/qtwebengine:6
	kde-plasma/plasma-workspace:6"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.kevinbburns.grammarly

	doins metadata.json
	doins -r contents
}
