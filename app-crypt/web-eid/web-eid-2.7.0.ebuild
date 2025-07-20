# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake readme.gentoo-r1 virtualx

LEI_COMMIT="f85a89216ecd9738b36e701b5a86da4d5152d3c4"
MY_PN="${PN}-app"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Digital signing and authentication operations with electronic ID"
HOMEPAGE="https://github.com/web-eid/web-eid-app"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://github.com/${PN}/libelectronic-id/archive/${LEI_COMMIT}.tar.gz -> ${MY_P}-lei.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/openssl:0=
	dev-qt/qtbase:6=[network,widgets]
	dev-qt/qtsvg:6=
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig
	test? ( dev-cpp/gtest:0= )"

DOC_CONTENTS="Firefox extension: https://addons.mozilla.org/firefox/addon/web-eid-webextension"

src_prepare() {
	default

	rmdir lib/libelectronic-id || die "rmdir failed"
	ln -s ../../libelectronic-id-"${LEI_COMMIT}" lib/libelectronic-id \
		|| die "ln failed for libelectronic-id"

	if ! use test ; then
		sed -i '/enable_testing()/,$d' {,lib/libelectronic-id/,lib/libelectronic-id/lib/libpcsc-cpp/,lib/libelectronic-id/lib/libpcsc-cpp/tests/lib/libpcsc-mock/}CMakeLists.txt \
			|| die "sed failed"
	fi

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
src_install() {
	readme.gentoo_create_doc
	cmake_src_install
}

pkg_postinst() {
	readme.gentoo_print_elog
}
