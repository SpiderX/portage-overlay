# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm xdg

PTL_COMMIT="6e86393f546429113e4ee78f7702eb820b21a0d2"
PP_COMMIT="8972055d87d46ae5388310844b1e4405b9276962"

DESCRIPTION="Linux perf GUI for performance analysis"
HOMEPAGE="https://github.com/KDAB/hotspot"
SRC_URI="https://github.com/KDAB/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/koenpoppe/PrefixTickLabels/archive/${PTL_COMMIT}.tar.gz
		-> koenpoppe-PrefixTickLabels-${PTL_COMMIT}.tar.gz
	https://github.com/KDAB/perfparser/archive/${PP_COMMIT}.tar.gz
		-> KDAB-perfparser-${PP_COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/zstd:=
	dev-libs/qcustomplot
	dev-libs/rustc-demangle
	dev-qt/qtbase:6[network,widgets]
	dev-qt/qtsvg:6
	dev-util/perf
	gui-libs/kddockwidgets:=
	kde-frameworks/karchive:6
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/knotifications:6
	kde-frameworks/ki18n:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/kio:6
	kde-frameworks/kitemmodels:6
	kde-frameworks/kitemviews:6
	kde-frameworks/kparts:6
	kde-frameworks/syntax-highlighting:6
	kde-frameworks/kwindowsystem:6
	kde-frameworks/solid:6
	kde-frameworks/threadweaver:6
	media-gfx/kgraphviewer
	virtual/libelf:="

src_prepare() {
	rmdir "${S}"/3rdparty/{PrefixTickLabels,perfparser} || die "rmdir failed"
	ln -s ../../perfparser-"${PP_COMMIT}"/ 3rdparty/perfparser \
		|| die "ln faild for perfparser"
	ln -s ../../PrefixTickLabels-"${PTL_COMMIT}"/ 3rdparty/PrefixTickLabels \
		|| die "ln faild for PrefixTickLabels"

	if ! use test ; then
		sed -i '/add_subdirectory(tests)/d' CMakeLists.txt \
			|| die "sed failed for CMakeLists.txt"
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQT6_BUILD=ON
	)
	cmake_src_configure
}
