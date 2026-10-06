# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
PLOCALES="ru"

inherit cargo cmake gnome2-utils plocale

DESCRIPTION="Desktop integration for waywallen"
HOMEPAGE="https://github.com/waywallen/waywallen-display"
EGIT_REPO_URI="https://github.com/waywallen/${PN}.git"

LICENSE="Apache-2.0 GPL-3+ ISC MIT Unicode-3.0"
SLOT="0"
IUSE="+egl gnome layershell plasma qml test vulkan"
REQUIRED_USE="gnome? ( vulkan )
	layershell? ( || ( egl vulkan ) )
	plasma? ( egl qml )"
RESTRICT="!test? ( test )"

RDEPEND="egl? ( media-libs/libglvnd )
	gnome? ( dev-libs/glib:2
		gnome-base/gnome-shell
		gui-libs/gtk:4
		gui-libs/libadwaita:1 )
	plasma? ( kde-frameworks/kirigami:6
		kde-frameworks/kwindowsystem:6
		kde-plasma/libplasma:6
		kde-plasma/plasma-workspace:6 )
	qml? ( dev-qt/qtbase:6[dbus,gui]
		dev-qt/qtdeclarative:6 )
	vulkan? ( media-libs/vulkan-loader )"
DEPEND="${RDEPEND}
	gnome? ( dev-libs/gobject-introspection )
	vulkan? ( dev-util/vulkan-headers )"
BDEPEND="sys-devel/gettext
	virtual/pkgconfig
	layershell? ( ${RUST_DEPEND}
			dev-util/glslang )"

src_unpack() {
	default
	git-r3_src_unpack
	use layershell && cargo_live_src_unpack
}

src_prepare() {
	my_rm_loc() {
		rm -f po/layer-shell/"${1}".po extensions/gnome/po/"${1}".po \
			extensions/kde/po/"${1}".po || die "rm failed for ${1}"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWAYWALLEN_DISPLAY_BUILD_TESTS="$(usex test)"
		-DCMAKE_DISABLE_FIND_PACKAGE_Vulkan="$(usex vulkan OFF ON)"
		-DWAYWALLEN_DISPLAY_PLUGIN_GOBJECT="$(usex gnome)"
		-DWAYWALLEN_DISPLAY_PLUGIN_GNOME="$(usex gnome)"
		-DWAYWALLEN_DISPLAY_PLUGIN_QML="$(usex qml)"
		-DWAYWALLEN_DISPLAY_WITH_EGL="$(usex egl)"
		-DWAYWALLEN_DISPLAY_WITH_VULKAN="$(usex vulkan)"
		-DWAYWALLEN_DISPLAY_REGEN_PROTO=OFF
	)

	cmake_src_configure

	use layershell && cargo_src_configure --bin waywallen-layer-shell \
		--no-default-features --features "layer-shell$(usev egl ',egl')$(usev vulkan ',vulkan')"
}

src_compile() {
	cmake_src_compile
	use layershell && cargo_src_compile
}

src_test() {
	cmake_src_test
	use layershell && cargo_src_test
}

src_install() {
	cmake_src_install
	use layershell && cargo_src_install --bin waywallen-layer-shell

	if use plasma ; then
		DESTDIR="${T}/kde-extension" \
			cmake --install "${BUILD_DIR}" --component kde_extension || die
		insinto /usr/share/plasma/wallpapers
		doins -r "${T}"/kde-extension/usr/org.waywallen.kde
	fi

	rm "${ED}"/usr/"$(get_libdir)"/libwaywallen_display.a || die
}

pkg_postinst() {
	use gnome && gnome2_schemas_update
}

pkg_postrm() {
	use gnome && gnome2_schemas_update
}
