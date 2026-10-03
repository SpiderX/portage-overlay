# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_LFS=1
LLVM_COMPAT=( 22 23 )
RUST_MIN_VER="1.88.0"

declare -A GIT_CRATES=(
	[mlua-extra]='https://github.com/hypengw/mlua-extra;df1d282170dd1718b8aeff405638c18cedd435ca;mlua-extra-%commit%'
)

inherit cargo edo git-r3 flag-o-matic llvm-r2 optfeature xdg

LUATO_COMMIT="df0c6f2d1cce2051b4711d36067619eda7933683"
NCREQUEST_COMMIT="cdaca8b5c523906fc0c9ed58cd5f2c7981b5a255"
QEXTRA_COMMIT="68f752fd38e3d7a923bf36d621f4a94be7b26fd8"
WAVSEN_COMMIT="529a01c632a28d57daaca2a3c8bd9fc6672df564"
RSTD_PV="0.1.5"
VVK_PV="0.1.0"

DESCRIPTION="Dynamic wallpaper manager for Linux"
HOMEPAGE="https://github.com/waywallen/waywallen"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
SRC_URI="https://github.com/litocpp/luato/archive/${LUATO_COMMIT}.tar.gz -> luato-${LUATO_COMMIT}.tar.gz
	https://github.com/hypengw/ncrequest/archive/${NCREQUEST_COMMIT}.tar.gz -> ncrequest-${NCREQUEST_COMMIT}.tar.gz
	https://github.com/hypengw/QExtra/archive/${QEXTRA_COMMIT}.tar.gz -> qextra-${QEXTRA_COMMIT}.tar.gz
	https://github.com/hypengw/wavsen/archive/${WAVSEN_COMMIT}.tar.gz -> wavsen-${WAVSEN_COMMIT}.tar.gz
	https://github.com/litocpp/rstd/archive/v${RSTD_PV}.tar.gz -> rstd-${RSTD_PV}.tar.gz
	https://github.com/litocpp/vvk/archive/v${VVK_PV}.tar.gz -> vvk-${VVK_PV}.tar.gz
	https://www.lua.org/ftp/lua-5.5.1.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 BSD CDLA-Permissive-2.0 ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"

RDEPEND="dev-qt/qtbase:6
	dev-qt/qtdeclarative:6
	dev-qt/qtgrpc:6
	dev-qt/qttools:6
	dev-qt/qtwebsockets:6
	media-libs/libva
	media-libs/mesa
	media-libs/vulkan-loader
	media-video/ffmpeg"
DEPEND="${RDEPEND}
	dev-libs/QmlMaterial
	dev-util/vulkan-headers"
BDEPEND="dev-build/lito"

PATCHES=( "${FILESDIR}/${PN}"-0.4.2-cargo-git-crate.patch
	"${FILESDIR}/${PN}"-0.4.2-source-local.patch )

DOCS=( {LOGGING,README}.md )

pkg_setup() {
	llvm-r2_pkg_setup
	rust_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
	default
}

src_prepare() {
	ln -s "${WORKDIR}/lua-5.5.1" "${WORKDIR}"/.lua || die
	ln -s "${WORKDIR}/luato-${LUATO_COMMIT}" .luato || die
	ln -s "${WORKDIR}/ncrequest-${NCREQUEST_COMMIT}" .ncrequest || die
	ln -s "${WORKDIR}/QExtra-${QEXTRA_COMMIT}" .qextra || die
	ln -s "${WORKDIR}/rstd-${RSTD_PV}" .rstd || die
	ln -s "${WORKDIR}/vvk-${VVK_PV}" .vvk || die
	ln -s "${WORKDIR}/wavsen-${WAVSEN_COMMIT}" .wavsen || die

	ln -s "${WORKDIR}/ncrequest-${NCREQUEST_COMMIT}" \
		"${WORKDIR}/QExtra-${QEXTRA_COMMIT}/.ncrequest" || die

	eapply --directory="${WORKDIR}/luato-${LUATO_COMMIT}" \
		"${FILESDIR}/${PN}"-0.4.2-luato-source-local.patch

	eapply --directory="${WORKDIR}/QExtra-${QEXTRA_COMMIT}" \
		"${FILESDIR}/${PN}"-0.4.2-qextra-source-local.patch

	default
}

src_configure() {
	append-cxxflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0

	cargo_src_configure
}

src_compile() {
	edo lito build --profile plain --use-env-flags
}

src_test() {
	local args=(
		--profile plain
		--offline
		--use-env-flags
		--build-dir "${WORKDIR}/test-build"
	)

	edo lito test --package waywallen-bridge "${args[@]}"
	edo lito test --package waywallen-i18n "${args[@]}"
	edo lito test --package waywallen-plugin-i18n "${args[@]}"
}

src_install() {
	einstalldocs

	local libdir
	libdir="$(get_libdir)"

	edo lito install --profile plain --no-build --prefix "${ED}/usr"

	if [[ ${libdir} != lib ]]; then
		edo mv "${ED}/usr/lib" "${ED}/usr/${libdir}"
		sed -i "s|^libdir=\${prefix}/lib$|libdir=\${prefix}/${libdir}|" \
			"${ED}/usr/${libdir}/pkgconfig/waywallen-bridge.pc" || die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "additional Wayland display integration" gui-libs/waywallen-display
	optfeature "Wallpaper Engine wallpaper support" media-gfx/open-wallpaper-engine
}
