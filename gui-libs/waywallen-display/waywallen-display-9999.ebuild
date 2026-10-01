# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1

inherit cargo cmake edo git-r3 gnome2-utils

DESCRIPTION="Desktop integration for waywallen"
HOMEPAGE="https://github.com/waywallen/waywallen-display"
EGIT_REPO_URI="https://github.com/waywallen/${PN}.git"

LICENSE="Apache-2.0 GPL-3+ ISC MIT Unicode-3.0"
SLOT="0"
IUSE="egl gnome layershell qml test vulkan"
REQUIRED_USE="layershell? ( || ( egl vulkan ) )"
RESTRICT="!test? ( test )"

RDEPEND="egl? ( media-libs/libglvnd )
	gnome? ( dev-libs/glib:2
		gui-libs/gtk:4 )
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

src_install() {
	cmake_src_install
	use layershell && cargo_src_install --bin waywallen-layer-shell
	edo rm "${ED}"/usr/"$(get_libdir)"/libwaywallen_display.a
}

pkg_postinst() {
	use gnome && gnome2_schemas_update
}

pkg_postrm() {
	use gnome && gnome2_schemas_update
}
