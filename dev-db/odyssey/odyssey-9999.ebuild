# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
CMAKE_IN_SOURCE_BUILD=1

inherit cmake git-r3 systemd

DESCRIPTION="Scalable PostgreSQL connection pooler"
HOMEPAGE="https://github.com/yandex/odyssey"
EGIT_REPO_URI="https://github.com/yandex/${PN}.git"

LICENSE="BSD-2"
SLOT="0"
IUSE="compression debug zlib zstd"
REQUIRED_USE="zlib? ( compression ) zstd? ( compression )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="acct-user/odyssey
	dev-db/postgresql:=
	dev-libs/openssl:0=
	net-nds/openldap:0=
	zlib? ( sys-libs/zlib:0= )
	zstd? ( app-arch/zstd:0= )
	sys-libs/pam"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i '/include(Packaging)/d' CMakeLists.txt || die "sed failed"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
		-DBUILD_COMPRESSION="$(usex compression)"
	)
	cmake_src_configure
}

src_test() {
	pushd "${S}"/test || die "pushd failed"
	./odyssey_test || die "tests failed"
	popd || die "popd failed"
}

src_install() {
	einstalldocs
	default

	insinto /etc/odyssey
	doins odyssey.conf
	keepdir /var/log/odyssey
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/odyssey.logrotate odyssey

	newinitd "${FILESDIR}"/odyssey.initd odyssey
	newconfd "${FILESDIR}"/odyssey.confd odyssey
	systemd_dounit scripts/systemd/odyssey.service
	systemd_dounit scripts/systemd/odyssey@.service
}
