# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Syllo/${PN}.git"

inherit cmake git-r3 xdg

DESCRIPTION="GPU & Accelerator process monitoring"
HOMEPAGE="https://github.com/Syllo/nvtop"

LICENSE="GPL-3"
SLOT="0"
IUSE="test video_cards_amdgpu video_cards_freedreno video_cards_intel video_cards_nvidia"
REQUIRED_USE="|| ( video_cards_amdgpu video_cards_freedreno video_cards_intel video_cards_nvidia )"
RESTRICT="!test? ( test )"

DEPEND="sys-libs/ncurses:=
	virtual/libudev:=
	video_cards_amdgpu? ( x11-libs/libdrm[video_cards_amdgpu] )
	video_cards_freedreno? ( x11-libs/libdrm[video_cards_freedreno] )
	video_cards_intel? ( x11-libs/libdrm[video_cards_intel] )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers:= )"
RDEPEND="${DEPEND}
	sys-kernel/linux-headers"
BDEPEND="virtual/pkgconfig
	test? ( dev-cpp/gtest )"

src_prepare() {
	sed -i '/add_library(testLib/a\\    ${PROJECT_SOURCE_DIR}/src/extract_processinfo_fdinfo.c' \
		tests/CMakeLists.txt || die "sed failed for tests/CMakeLists.txt"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_FLAGS="${CFLAGS} -I/usr/include/libdrm"
		-DAMDGPU_SUPPORT="$(usex video_cards_amdgpu)"
		-DAPPLE_SUPPORT=OFF
		-DASCEND_SUPPORT=OFF
		-DBUILD_TESTING="$(usex test)"
		-DINTEL_SUPPORT="$(usex video_cards_intel)"
		-DMSM_SUPPORT="$(usex video_cards_freedreno)"
		-DNVIDIA_SUPPORT="$(usex video_cards_nvidia)"
		-DPANFROST_SUPPORT=OFF
	)
	cmake_src_configure
}
