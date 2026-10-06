# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="aho-corasick@1.1.4
	anyhow@1.0.102
	ash@0.38.0+1.3.281
	bitflags@2.13.0
	block-buffer@0.10.4
	block@0.1.6
	cc@1.2.61
	cfg-if@1.0.4
	crypto-common@0.1.7
	digest@0.10.7
	dlib@0.5.3
	downcast-rs@1.2.1
	env_logger@0.10.2
	errno@0.3.14
	find-msvc-tools@0.1.9
	generic-array@0.14.7
	gettext-rs@0.7.7
	gettext-sys@0.26.0
	hermit-abi@0.5.2
	humantime@2.3.0
	is-terminal@0.4.17
	itoa@1.0.18
	lazy_static@1.5.0
	libc@0.2.186
	libloading@0.8.9
	linux-raw-sys@0.12.1
	locale_config@0.3.0
	log@0.4.32
	malloc_buf@0.0.6
	md-5@0.10.6
	memchr@2.8.1
	niri-ipc@26.4.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	pkg-config@0.3.33
	proc-macro2@1.0.106
	quick-xml@0.39.4
	quote@1.0.45
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rustix@1.1.4
	scoped-tls@1.0.1
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.150
	shlex@1.3.0
	smallvec@1.15.1
	syn@2.0.117
	temp-dir@0.1.16
	termcolor@1.4.1
	thiserror-impl@2.0.18
	thiserror@2.0.18
	typenum@1.20.1
	unicode-ident@1.0.24
	version_check@0.9.5
	wayland-backend@0.3.15
	wayland-client@0.31.14
	wayland-protocols-wlr@0.3.12
	wayland-protocols@0.32.12
	wayland-scanner@0.31.10
	wayland-sys@0.31.11
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.61.2
	zmij@1.0.21"

CARGO_OPTIONAL=1
PLOCALES="ru"

inherit cargo cmake gnome2-utils plocale

DESCRIPTION="Desktop integration for waywallen"
HOMEPAGE="https://github.com/waywallen/waywallen-display"
SRC_URI="https://github.com/waywallen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 GPL-3+ ISC MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
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
	use layershell && cargo_src_unpack
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
