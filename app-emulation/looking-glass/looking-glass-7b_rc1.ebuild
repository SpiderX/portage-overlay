# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MODULES_OPTIONAL_IUSE="modules"

inherit cmake desktop linux-mod-r1 tmpfiles xdg

MY_PV="$(ver_cut 2 "${PV^^}")$(ver_cut 1)-$(ver_cut 3-)"

DESCRIPTION="A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.io https://github.com/gnif/LookingGlass"
SRC_URI="https://looking-glass.io/artifact/${MY_PV}/source -> ${P}.tar.gz
	binary? ( https://looking-glass.io/artifact/${MY_PV}/host -> looking-glass-host-${PV}.zip )"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="binary gnome host iso obs opengl pipewire pulseaudio wayland X"
REQUIRED_USE="gnome? ( wayland ) iso? ( binary )"
RESTRICT="mirror"

RDEPEND="media-libs/fontconfig:1.0
	media-libs/libglvnd
	sys-libs/binutils-libs:=
	x11-libs/libxkbcommon
	obs? ( media-video/obs-studio )
	opengl? ( virtual/opengl )
	pipewire? ( media-video/pipewire:=
		media-libs/libsamplerate )
	pulseaudio? ( media-libs/libpulse
		media-libs/libsamplerate )
	X? ( x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXfixes
		x11-libs/libXScrnSaver
		x11-libs/libXinerama
		x11-libs/libXcursor
		x11-libs/libXpresent )
	wayland? ( dev-libs/wayland
		gnome? ( gui-libs/libdecor ) )"
DEPEND="${RDEPEND}
	app-emulation/spice-protocol
	dev-libs/nettle[gmp]
	wayland? ( dev-libs/wayland-protocols )"
BDEPEND="virtual/pkgconfig
	host? ( app-arch/unzip )
	iso? ( app-cdr/cdrtools )
	wayland? ( dev-util/wayland-scanner )"

PATCHES=( "${FILESDIR}/${P}-kernel-6.10.patch" )

CONFIG_CHECK="~UIO"

src_unpack() {
	einfo "Unpacking ${P}.tar.gz ..."
	tar -xzf "${DISTDIR}/${P}.tar.gz" "${PN}-${MY_PV}" \
		|| die "unpack failed ${P}"
	if use binary ; then
		einfo "Unpacking looking-glass-host-${PV}.zip ..."
		mkdir "${PN}-host" || die "mkdir failed"
		unzip "${DISTDIR}/looking-glass-host-${PV}.zip" -d "${PN}-host" \
			|| die "unpack failed for host"
	fi
}

src_prepare() {
	if use iso ; then
		mkisofs -lJR -iso-level 4 -o "looking-glass-host-${PV}.iso" "${WORKDIR}/looking-glass-host" \
			|| die "mkisofs failed"
	fi

	# override warning
	sed -i '1 i\#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"' \
		host/platform/Linux/capture/pipewire/src/portal.c || die "sed failed"

	for project in client$(usex host ' host' '')$(usex obs ' obs' '') ; do
		CMAKE_USE_DIR="${S}/${project}"
		cmake_src_prepare "$@"
	done
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_EGL=ON
		-DENABLE_LIBDECOR="$(usex gnome)"
		-DENABLE_OPENGL="$(usex opengl)"
		-DENABLE_PIPEWIRE="$(usex pipewire)"
		-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
		-DENABLE_WAYLAND="$(usex wayland)"
		-DENABLE_X11="$(usex X)"
	)

	for project in client$(usex host ' host' '')$(usex obs ' obs' '') ; do
		CMAKE_USE_DIR="${S}/${project}"
		BUILD_DIR="${CMAKE_USE_DIR}_build"
		cmake_src_configure "$@"
	done
	set_arch_to_kernel
}

src_compile() {
	for project in client$(usex host ' host' '')$(usex obs ' obs' '') ; do
		CMAKE_USE_DIR="${S}/${project}"
		BUILD_DIR="${CMAKE_USE_DIR}_build"
		cmake_src_compile "$@"
	done

	local modlist=( kvmfr=misc:module )
	local modargs=( KVER="${KV_FULL}" KDIR="${KV_OUT_DIR}" )
	use modules && linux-mod-r1_src_compile
}

src_install() {
	for project in client$(usex host ' host' '')$(usex obs ' obs' '') ; do
		CMAKE_USE_DIR="${S}/${project}"
		BUILD_DIR="${CMAKE_USE_DIR}_build"
		cmake_src_install "$@"
	done

	newtmpfiles "${FILESDIR}"/looking-glass.tmpfile looking-glass.conf
	newicon -s 128 "${S}"/resources/icon-128x128.png looking-glass-client.png

	if use X && ! use wayland || ! use X && use wayland ; then
		domenu "${FILESDIR}"/looking-glass.desktop
	fi
	if use X && use wayland ; then
		domenu "${FILESDIR}/looking-glass-x.desktop"
		newmenu "${FILESDIR}/looking-glass.desktop" looking-glass-wayland.desktop
	fi

	insinto /usr/share/looking-glass
	use binary && doins "${WORKDIR}"/looking-glass-host/looking-glass-host-setup.exe
	use iso && doins "looking-glass-host-${PV}.iso"

	use modules && linux-mod-r1_src_install
}

pkg_postinst() {
	tmpfiles_process looking-glass.conf
	xdg_pkg_postinst
	use modules && linux-mod-r1_pkg_postinst
}
