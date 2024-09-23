# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

COMMIT="1fd1a3fdf9cb0b6d43c89926f760d4e84d8f31d5"

DESCRIPTION="Sliding animation for notification windows"
HOMEPAGE="https://github.com/zzag/kwin-effects-sliding-notifications"
SRC_URI="https://github.com/zzag/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+ MIT"
SLOT="6"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kwindowsystem:6
	kde-plasma/kwin:6
	media-libs/libepoxy
	x11-libs/libxcb:="
DEPEND="${RDEPEND}"
BDEPEND="kde-frameworks/extra-cmake-modules"
