# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/yandex/${PN}.git"

inherit cmake-utils git-r3 systemd user

DESCRIPTION="Scalable PostgreSQL connection pooler"
HOMEPAGE="https://github.com/yandex/odyssey"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="debug libressl"

RDEPEND="!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
DEPEND="${RDEPEND}
	app-admin/logrotate"

pkg_setup() {
	enewgroup "${PN}"
	enewuser "${PN}" -1 -1 /etc/"${PN}" "${PN}"
}

src_prepare() {
	default

	# Remove git reference
	sed -i "/execute_process/s/git describe --always/echo ${PV}/" \
		CMakeLists.txt || die "sed for CMakeLists.txt failed"

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE="$(usex debug Debug Release)"
	)
	cmake-utils_src_configure
}

src_install() {
	einstalldocs

	dobin "${S}"_build/sources/"${PN}"

	insinto /etc/"${PN}"
	newins "${PN}".conf "${PN}".conf.example
	keepdir /var/log/"${PN}" /etc/"${PN}"
	fowners -R "${PN}":"${PN}" /etc/"${PN}" /var/log/"${PN}" /etc/"${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/"${PN}".logrotate "${PN}"

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit scripts/systemd/"${PN}".service
	systemd_dounit scripts/systemd/"${PN}"@.service
}
