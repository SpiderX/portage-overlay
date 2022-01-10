# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Windows 7 style indicator for Latte Dock"
HOMEPAGE="https://github.com/psifidotos/latte-indicator-win7"
SRC_URI="https://github.com/psifidotos/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-misc/latte-dock"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/packages/org.kde.latte.win7
	doins metadata.desktop
	doins -r contents
}
