# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/rozhuk-im/${PN}.git"

inherit cmake git-r3

DESCRIPTION="Program for IP TV streaming on the network via HTTP"
HOMEPAGE="https://github.com/rozhuk-im/msd"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="acct-user/msd"

DOCS=( README.md conf/{msd_channels,msd_channels2,msd_minimal}.conf )

src_prepare() {
	# Respect sandbox, immutability for install
	sed -i  -e '/install(CODE/s/CONFDIR/CONF/' \
		-e '/install_if_not_exists(conf/s/install_if_not_exists/install_config/' \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"
	# Follow FHS
	sed -i 's|/root/msd/msd.log|/var/log/msd.log|' conf/msd.conf \
		|| die "sed failed for conf/msd.conf"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCONF="${EPREFIX}/etc/msd"
		-DCONFDIR="/etc/msd"
		-DENABLE_FULL_DEBUG="$(usex debug ON OFF)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	newinitd "${FILESDIR}"/msd.initd msd
	newconfd "${FILESDIR}"/msd.confd msd
}
