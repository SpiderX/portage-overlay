# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Analog clock applet that respects Latte items size"
HOMEPAGE="https://github.com/psifidotos/applet-latte-analogclock"
SRC_URI="https://github.com/psifidotos/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-plasma/plasma-workspace:5"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.kde.latte.analogclock
	doins metadata.desktop
	doins -r contents
}
