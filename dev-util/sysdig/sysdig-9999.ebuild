# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3 cmake-utils linux-mod

DESCRIPTION="System-level exploration and troubleshooting tool"
HOMEPAGE="http://www.sysdig.org/"
EGIT_REPO_URI="https://github.com/draios/${PN}.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="debug examples modules"

RDEPEND="dev-lang/luajit:2
	>dev-libs/jsoncpp-0.5.0-r1
	sys-libs/zlib
"
DEPEND="virtual/os-headers
	${RDEPEND}"

REQUIRED_USE="!kernel_linux? ( !modules )"

MODULE_NAMES="sysdig-probe(misc:${S}_build/driver)"
MODULES_OPTIONAL_USE="modules"

pkg_setup() {
	use modules && linux-mod_pkg_setup
}

src_prepare() {
	if ! use debug ; then
		sed -r '/\tset\(CMAKE_C(XX)?_FLAGS\ "\$\{CMAKE_C(XX)?_FLAGS\}\ -Wall/s/ -ggdb//' \
			-i "${S}"/CMakeLists.txt || die "sed on CMakeList.txt failed"
	fi
	cmake-utils_src_prepare
	epatch_user
}

src_configure() {
	unset ARCH
	local mycmakeargs=(
		$(echo -DUSE_BUNDLED_LUAJIT=OFF)
		$(echo -DUSE_BUNDLED_JSONCPP=OFF)
		$(echo -DUSE_BUNDLED_ZLIB=OFF)
		$(cmake-utils_use_build modules DRIVER)
		$(cmake-utils_use_build examples LIBSCAP_EXAMPLES)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	use modules && linux-mod_src_install
}

pkg_preinst() {
	einfo "Removing source files from installation image..."
	rm -rf "${D}/usr/src"
	use modules && linux-mod_pkg_preinst
}

pkg_postinst() {
	if use modules ; then
		linux-mod_pkg_postinst
		ewarn "This package installs kernel module ${PN}-probe.ko."
		ewarn "Don't forget to load the module before running sysdig."
	fi
}

pkg_postrm() {
	use modules && linux-mod_pkg_postrm
}
