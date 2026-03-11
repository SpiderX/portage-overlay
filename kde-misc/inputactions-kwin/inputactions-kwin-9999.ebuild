# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 readme.gentoo-r1 udev

DESCRIPTION="Mouse and touchpad gestures for Plasma 6 Wayland"
HOMEPAGE="https://github.com/InputActions/kwin"
EGIT_REPO_URI="https://github.com/InputActions/kwin.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="ctl test udev"
RESTRICT="!test? ( test )"

RDEPEND="dev-cpp/yaml-cpp:=
	dev-libs/libevdev
	dev-qt/qtbase:6[dbus,widgets]
	kde-frameworks/kcmutils:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kguiaddons:6
	kde-frameworks/ki18n:6
	kde-plasma/kwin:6
	x11-libs/libxkbcommon
	ctl? ( kde-misc/inputactions-ctl )"
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
