# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="2161f511ee517bd29e7a8ff8c1351b7e799c2187"

DESCRIPTION="Plasma 5 applet that acts as a spacer between applets"
HOMEPAGE="https://github.com/psifidotos/applet-latte-spacer"
SRC_URI="https://github.com/psifidotos/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-plasma/plasma-workspace:6"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.latte.spacer
	doins metadata.json
	doins -r contents
}
