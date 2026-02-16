# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

MY_PN=${PN^}
MY_P=${P^}

DESCRIPTION="A modern style for qt applications"
HOMEPAGE="https://github.com/Bali10050/Darkly"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Bali10050/Darkly.git"
else
	SRC_URI="https://github.com/Bali10050/Darkly/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="6"

RDEPEND="dev-qt/qtbase:6[dbus,gui,widgets]
	dev-qt/qtdeclarative:6
	kde-frameworks/frameworkintegration:6
	kde-frameworks/kcolorscheme:6
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/kguiaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kirigami:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kwindowsystem:6
	kde-plasma/kdecoration:6"
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/kcmutils:6"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT6=ON
		-DBUILD_QT5=OFF
	)
	ecm_src_configure
}
