# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR=emake
EGIT_REPO_URI="https://github.com/yandex/${PN}.git"
EGIT_SUBMODULES=()

inherit cmake git-r3 systemd

DESCRIPTION="Scalable PostgreSQL connection pooler"
HOMEPAGE="https://github.com/yandex/odyssey"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="acct-user/odyssey
	dev-db/postgresql:=
	dev-libs/openssl:0=
	sys-libs/pam"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# Remove git reference, don't build test (no tests)
	sed -i  -e "/execute_process/s/git describe --always/echo ${PV}/" \
		-e "/execute_process/s/git rev-list --count HEAD/echo ${PV}/" \
		-e "/add_subdirectory(test)/d" \
		-e "/add_subdirectory(stress)/d" \
		CMakeLists.txt || die "sed for CMakeLists.txt failed"

	# Don't build valgrind
	sed -i '/option(BUILD_VALGRIND/s/ON/OFF/' \
		third_party/machinarium/CMakeLists.txt \
		|| die "sed failed for machinarium/CMakeLists.txt"

	# Fix build
	sed -i 's/IOV_MAX/INT_MAX/' third_party/machinarium/sources/write.c \
		|| die "sed failed for write.c"

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
	doins odyssey.conf
	keepdir /var/log/odyssey
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/odyssey.logrotate odyssey

	newinitd "${FILESDIR}"/odyssey.initd odyssey
	newconfd "${FILESDIR}"/odyssey.confd odyssey
	systemd_dounit scripts/systemd/odyssey.service
	systemd_dounit scripts/systemd/odyssey@.service
}
