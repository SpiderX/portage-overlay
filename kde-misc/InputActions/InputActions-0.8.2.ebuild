# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake readme.gentoo-r1 udev

DESCRIPTION="Mouse and touchpad gestures for Hyprland, Plasma 6 Wayland"
HOMEPAGE="https://github.com/taj-ny/InputActions"
SRC_URI="https://github.com/taj-ny/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kde hyprland test udev"
RESTRICT="!test? ( test )"

RDEPEND="dev-cpp/yaml-cpp:=
	dev-libs/libevdev
	x11-libs/libxkbcommon
	hyprland? ( dev-libs/libinput:=
		gui-wm/hyprland
		x11-libs/libdrm
		x11-libs/pango
		x11-libs/pixman )
	kde? ( dev-qt/qtbase:6[dbus,widgets]
		kde-frameworks/kcmutils:6
		kde-frameworks/kconfigwidgets:6
		kde-frameworks/kguiaddons:6
		kde-frameworks/ki18n:6
		kde-plasma/kwin:6 )"
BDEPEND="kde-frameworks/extra-cmake-modules
	virtual/pkgconfig
	test? ( dev-cpp/gtest:= )"

DOC_CONTENTS="Execute to run plugin:\\n
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect kwin_gestures\\n
or open the Desktop Effects page in System Settings and enable InputActions\\n
in the Tools category.\\n
Place configuration file into ~/.config/inputactions/config.yaml\\n
Configuration reloads automatically when the file is modified, for manual reload:\\n
qdbus6 org.inputactions / reloadConfig\\n
More info at https://wiki.inputactions.org/main/\\n\\n"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS="$(usex test)"
		-DINPUTACTIONS_BUILD_HYPRLAND="$(usex hyprland)"
		-DINPUTACTIONS_BUILD_KWIN="$(usex kde)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	readme.gentoo_create_doc

	if use udev ; then
		local udevrules="${T}/71-touchpad.rules"
		cat > "${udevrules}" <<-EOF
			ENV{ID_INPUT_TOUCHPAD}=="1", TAG+="uaccess"
		EOF
		udev_dorules "${udevrules}"
	fi
}

pkg_postinst() {
	readme.gentoo_print_elog
	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}
