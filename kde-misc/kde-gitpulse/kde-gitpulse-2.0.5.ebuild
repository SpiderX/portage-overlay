# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature qt-utils

DESCRIPTION="Plasma 6 System Tray widget for GitHub"
HOMEPAGE="https://github.com/Muddyblack/kde-gitpulse"
SRC_URI="https://github.com/Muddyblack/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtdeclarative:6
	kde-frameworks/kcmutils:6
	kde-frameworks/kdeclarative:6
	kde-frameworks/kirigami:6
	kde-frameworks/knotifications:6
	kde-plasma/libplasma:6
	kde-plasma/plasma5support:6"

src_compile() { :; }

src_test() {
	emake QMLRUN="$(qt_get_broot_binary 6 qml)" test
}

src_install() {
	default

	insinto /usr/share/plasma/plasmoids/org.muddyblack.gitpulse
	doins -r package/.
}

pkg_postinst() {
	optfeature "obtaining the GitHub authentication token from GitHub CLI" dev-util/github-cli
}
