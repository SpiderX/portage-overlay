# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="a0292b5fd9c2da38cf5bf319edf77595eddbec80"
MY_PN="com.kevinbburns.grammarly"

DESCRIPTION="KDE Plasma6 Panel Widget for a Webview to Grammarly Editor"
HOMEPAGE="https://github.com/kevinbburns/com.kevinbburns.grammarly"
SRC_URI="https://github.com/kevinbburns/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="BSD"
SLOT="6"
KEYWORDS="~amd64 ~x86"

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
