# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop xdg

PTL_COMMIT="824dcda"
PP_COMMIT="617194e"

DESCRIPTION="Linux perf GUI for performance analysis"
HOMEPAGE="https://github.com/KDAB/hotspot"
SRC_URI="https://github.com/KDAB/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://api.github.com/repos/koenpoppe/PrefixTickLabels/tarball/${PTL_COMMIT} -> koenpoppe-PrefixTickLabels-${PTL_COMMIT}.tar.gz
	https://api.github.com/repos/KDAB/perfparser/tarball/${PP_COMMIT} -> KDAB-perfparser-${PP_COMMIT}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
RESTRICT="test" # fails

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	kde-frameworks/extra-cmake-modules:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
	kde-frameworks/kitemmodels:5
	kde-frameworks/kitemviews:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/solid:5
	kde-frameworks/threadweaver:5
	dev-util/perf
	virtual/libelf:="
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"

src_unpack() {
	default

	rmdir "${S}"/3rdparty/{PrefixTickLabels,perfparser} || die "rmdir failed"
	ln -s "${WORKDIR}"/KDAB-perfparser-617194e/ "${S}"/3rdparty/perfparser \
		|| die "ln faild for perfparser"
	ln -s "${WORKDIR}"/koenpoppe-PrefixTickLabels-824dcda/ "${S}"/3rdparty/PrefixTickLabels \
		|| die "ln faild for PrefixTickLabels"
}

src_prepare() {
	if ! use test ; then
		sed -i '/add_subdirectory(tests)/d' CMakeLists.txt \
			|| die "sed failed for CMakeLists.txt"
	fi

	cmake_src_prepare
}

src_install() {
	cmake_src_install

	domenu hotspot.desktop
	insinto /usr/share/metainfo
	doins com.kdab.Hotspot.appdata.xml
}
