# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="0340401f8408c8b927b436438c775d9ab7661584"

DESCRIPTION="Plasma 5 applet that acts as a separator between applets"
HOMEPAGE="https://github.com/doncsugar/applet-latte-separator/tree/plasma6"
SRC_URI="https://github.com/doncsugar/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
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

	insinto /usr/share/plasma/plasmoids/org.kde.latte.separator
	doins metadata.json
	doins -r contents
}
