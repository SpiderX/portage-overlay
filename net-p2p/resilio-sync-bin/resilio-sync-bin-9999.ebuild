# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-bin/}"
BASE_URI="https://download-cdn.resilio.com/stable/linux--arch-/${MY_PN}_-arch-.tar.gz"

inherit pax-utils systemd tmpfiles user

NAME="rslsync"
QA_PREBUILT="usr/bin/${NAME}"

DESCRIPTION="Resilient, fast and scalable file synchronization tool"
HOMEPAGE="https://getsync.com/"
SRC_URI="amd64? ( ${BASE_URI//-arch-/x64} )
	arm? ( ${BASE_URI//-arch-/armhf} )
	x86? ( ${BASE_URI//-arch-/i386} )"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS=""
IUSE="pax_kernel systemd"
RESTRICT="bindist mirror"
S="${WORKDIR}"

pkg_setup() {
	enewgroup ${NAME}
	enewuser ${NAME} -1 -1 /var/lib/${MY_PN} ${NAME}
}

src_install() {
	dobin ${NAME}
	use pax_kernel && pax-mark m "${ED%/}"/usr/bin/${NAME}

	dodir /var/log/${MY_PN}

	keepdir /etc/${NAME} /var/lib/${MY_PN}/ /var/lib/${MY_PN}/.sync
	fperms 0700 /etc/${MY_PN} /var/lib/${MY_PN} /var/lib/${MY_PN}/.sync \
		/var/log/${MY_PN}
	fowners -R ${NAME}:${NAME} /etc/${MY_PN} /var/lib/${MY_PN} \
		/var/log/${MY_PN}

	newtmpfiles "${FILESDIR}"/${MY_PN}.tmpfile ${MY_PN}.conf

	use systemd || newinitd "${FILESDIR}"/${MY_PN}.initd ${MY_PN}
	use systemd || newconfd "${FILESDIR}"/${MY_PN}.confd ${MY_PN}
	use systemd && systemd_dounit "${FILESDIR}"/${MY_PN}.service
	use systemd && systemd_newuserunit "${FILESDIR}"/${MY_PN}-user.service \
				${MY_PN}.service
}

pkg_preinst() {
	# Generate sample config
	"${ED%/}"/usr/bin/${NAME} --dump-sample-config > \
		"${ED%/}"/etc/${MY_PN}/config.json || die "generate config failed"
	fowners ${NAME}:${NAME} /etc/${MY_PN}/config.json
	# Uncomment config directives and change their values
	sed -i \
		-e "/storage_path/s|//| |g" \
		-e "/pid_file/s|//| |g" \
		-e "/storage_path/s|/home/user|/var/lib/resilio-sync|g" \
		-e "/pid_file/s|resilio/resilio-sync|g" \
		"${ED%/}"/etc/${MY_PN}/config.json || die "sed for pkg_preinst failed"
}

pkg_postinst() {
	tmpfiles_process ${MY_PN}.conf

	elog "You may need to review /etc/${MY_PN}/config.json"
	elog "Defalt metadata path is /var/lib/${MY_PN}/.sync"
	elog "Default web-gui URL is http://localhost:8888/"
	elog ""
	elog "You must be in the ${NAME} group to use Resilio Sync."
}
