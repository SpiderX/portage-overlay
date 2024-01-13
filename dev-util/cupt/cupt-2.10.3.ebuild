# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 cmake

DESCRIPTION="Package manager for Debian"
HOMEPAGE="https://github.com/jackyf/cupt"
SRC_URI="https://github.com/jackyf/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc"

RDEPEND="dev-libs/boost:0=
	dev-libs/libgcrypt:0=
	>=net-misc/curl-7.72.0[gnutls]"
DEPEND="${RDEPEND}
	sys-libs/readline:0="
BDEPEND="dev-util/debhelper
	sys-devel/gettext
	doc? ( app-text/doxygen )"

src_prepare() {
	# Don't link against Debian libcurl
	sed -i '/target_link_libraries/s/-gnutls//' cpp/downloadmethods/CMakeLists.txt \
		|| die "sed failed for cpp/downloadmethods/CMakeLists.txt"
	# Respect multilib paths
	sed -i '/install(TARGETS/s/lib)/lib64)/' cpp/lib/CMakeLists.txt \
		|| die "sed failed for cpp/lib/CMakeLists.txt"

	if ! use doc ; then
		sed -i '/add_subdirectory(doc)/d' CMakeLists.txt \
			|| die "sed failed for CMakeLists.txt"
	fi

	cmake_src_prepare
}

src_install() {
	cmake_src_install

	newbashcomp scripts/bash_completion cupt
	insinto /etc/logrotate.d
	newins scripts/logrotate cupt
}
