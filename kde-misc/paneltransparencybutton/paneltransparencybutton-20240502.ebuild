# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="cfcd80a76776ee40142f6c1a72fd66b93b89bc73"

DESCRIPTION="Enable/disable transparency for specific plasma panels"
HOMEPAGE="https://github.com/TheEssem/paneltransparencybutton"
SRC_URI="https://github.com/TheEssem/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
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

	insinto /usr/share/plasma/plasmoids/org.kde.paneltransparencybutton
	doins metadata.json
	doins -r contents
}
