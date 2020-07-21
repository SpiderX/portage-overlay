# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/yandex/${PN}.git"

inherit cmake git-r3 systemd

DESCRIPTION="Scalable PostgreSQL connection pooler"
HOMEPAGE="https://github.com/yandex/odyssey"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug libressl"

DEPEND="!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}
	acct-user/odyssey
	app-admin/logrotate"

src_prepare() {
	default

	# Remove git reference
	sed -i "/execute_process/s/git describe --always/echo ${PV}/" \
		CMakeLists.txt || die "sed for CMakeLists.txt failed"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
	)
	cmake_src_configure
}

src_install() {
	einstalldocs

	dobin "${S}"_build/sources/odyssey

	insinto /etc/odyssey
	newins odyssey.conf odyssey.conf.example

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/odyssey.logrotate odyssey

	newinitd "${FILESDIR}"/odyssey.initd odyssey
	newconfd "${FILESDIR}"/odyssey.confd odyssey
	systemd_dounit scripts/systemd/odyssey.service
	systemd_dounit scripts/systemd/odyssey@.service

	diropts -o odyssey -g odyssey
	keepdir /var/log/odyssey
}
