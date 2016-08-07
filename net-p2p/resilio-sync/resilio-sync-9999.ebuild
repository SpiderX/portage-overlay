# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit user systemd pax-utils

NAME="btsync"
QA_PREBUILT="usr/bin/${NAME}"

DESCRIPTION="Resilient, fast and scalable file synchronization tool"
HOMEPAGE="https://getsync.com/"
SRC_URI="amd64? ( https://download-cdn.getsync.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz )
	x86? ( https://download-cdn.getsync.com/stable/linux-i386/BitTorrent-Sync_i386.tar.gz )
	arm? ( https://download-cdn.getsync.com/stable/linux-arm/BitTorrent-Sync_arm.tar.gz )
"
LICENSE="BitTorrent no-source-code"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64 ~arm"
IUSE="systemd"

RESTRICT="mirror"
DOCS=( README LICENSE.TXT )
S="${WORKDIR}"

pkg_setup() {
	enewgroup ${NAME}
	enewuser ${NAME} -1 -1 /var/lib/${NAME} ${NAME}
}

src_install() {
	dobin ${NAME}
	pax-mark m "${D}"/usr/bin/${NAME}

	keepdir /etc/${NAME} /var/lib/${NAME}/ /var/lib/${NAME}/.sync
	fperms 0700 /etc/${NAME} /var/lib/${NAME} /var/lib/${NAME}/.sync
	fowners -R ${NAME}:${NAME} /etc/${NAME} /var/lib/${NAME}

	use systemd || newinitd "${FILESDIR}"/${NAME}.initd ${NAME}
	use systemd || newconfd "${FILESDIR}"/${NAME}.confd ${NAME}
	use systemd && systemd_dounit "${FILESDIR}"/${NAME}.service
}

pkg_preinst() {
	# Generate sample config
	"${D}"/usr/bin/${NAME} --dump-sample-config > \
		"${D}"/etc/${NAME}/${NAME}.conf
	fowners ${NAME}:${NAME} /etc/${NAME}/${NAME}.conf
	# Uncomment config directives and change its values
	sed -i  \
		-e "/storage_path/s|//| |g" \
		-e "/pid_file/s|//| |g" \
		-e "/storage_path/s|/home/user/.sync|/var/lib/${NAME}/.sync|g" \
		-e "/pid_file/s|/var||g" \
		"${D}"/etc/${NAME}/${NAME}.conf || die "sed for pkg_preinst failed"
}

pkg_postinst() {
	elog "You may need to review /etc/${NAME}/btsync.conf"
	elog "Defalt metadata path is /var/lib/${NAME}"
	elog "Default web-gui URL is http://localhost:8888/"
}
