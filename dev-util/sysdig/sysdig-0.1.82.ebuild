# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils cmake-utils linux-mod

DESCRIPTION="System-level exploration and troubleshooting tool"
HOMEPAGE="http://www.sysdig.org/"
SRC_URI="https://github.com/draios/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="debug examples modules"

RDEPEND="dev-lang/luajit
	dev-libs/jsoncpp
	sys-libs/zlib
"
DEPEND="virtual/linux-sources
	${RDEPEND}"

CONFIG_CHECK="~TRACEPOINTS ~HAVE_SYSCALL_TRACEPOINTS"
MODULES_OPTIONAL_USE="modules"
MODULE_NAMES="sysdig-probe(sysdig:${S}/driver)"

src_prepare() {
	if ! use debug ; then
		sed -i 's/-ggdb//' "${S}"/CMakeLists.txt || die "sed on CMakeList.txt failed"
	fi

	cmake-utils_src_prepare

	epatch_user
}

src_configure() {
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
	linux-mod_src_install
}
