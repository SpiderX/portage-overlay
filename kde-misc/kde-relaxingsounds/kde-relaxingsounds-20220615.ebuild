# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="4d746578c5ca59924eedcae4eb8a1ad6cb06cd76"
MY_PN="${PN//-/_}"

DESCRIPTION="Plasma 5 widget for play relaxing sounds"
HOMEPAGE="https://github.com/Prayag2/kde_relaxingsounds"
SRC_URI="https://github.com/Prayag2/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

RDEPEND="kde-frameworks/plasma:5"

S="${WORKDIR}/${MY_PN}-${COMMIT}"

src_prepare() {
	default
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/com.github.prayag2.relaxingsounds

	doins package/metadata.json
	doins -r package/contents
}
