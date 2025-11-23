# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="tremotesf2"

DESCRIPTION="A remote GUI for transmission"
HOMEPAGE="https://github.com/equeim/tremotesf2"
SRC_URI="https://github.com/equeim/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-qt/qtbase:6[dbus,network,widgets]
	dev-qt/qtsvg:6
	kde-frameworks/kwidgetsaddons:6
	kde-frameworks/kwindowsystem:6"
DEPEND="${RDEPEND}
	>=dev-libs/cxxopts-3.2.1:0=
	>=dev-libs/libfmt-10.1.0:0=
	net-libs/libpsl
	sys-devel/gettext"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig
	test? ( dev-cpp/cpp-httplib:0= )"

DOCS=( {CHANGELOG,README}.md )

src_configure() {
	local mycmakeargs=(
		-DTREMOTESF_WITH_HTTPLIB="$(usex test system none)"
	)

	cmake_src_configure
}
