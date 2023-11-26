# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="84bb148ce58f0512357de7ed12c18c55356bc17f"

DESCRIPTION="Plasma 5 widget for quick access to favorite folders"
HOMEPAGE="https://github.com/enky-marte/plasma-applet-favoriteFolders"
SRC_URI="https://github.com/enky-marte/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-plasma/plasma-workspace:5"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/favoriteFolders

	doins package/metadata.desktop
	doins -r package/contents
}
