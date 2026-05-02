# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="ar bg ca cs da de el eo es et fi fr fur he hi hr hu it ja ko lt nb_NO nl pa pl pt ru si sk tr uk vi zh_CN"

inherit cmake git-r3 plocale

DESCRIPTION="A kwallet like functionality for lxqt"
HOMEPAGE="https://github.com/lxqt/lxqt_wallet"
EGIT_REPO_URI="https://github.com/lxqt/lxqt_wallet.git"

LICENSE="GPL-2+"
SLOT="0"
IUSE="keyring kwallet"

RDEPEND="dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-libs/libgcrypt:0=
	keyring? ( app-crypt/libsecret )
	kwallet? ( kde-frameworks/kwallet:6 )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	my_rm_loc() {
		sed -i "/frontend\/lxqt-wallet_${1}.qm/d" frontend/CMakeLists.txt || die "sed failed"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DNOSECRETSUPPORT="$(usex keyring false true)"
		-DNOKDESUPPORT="$(usex kwallet false true)"
	)
	cmake_src_configure
}
