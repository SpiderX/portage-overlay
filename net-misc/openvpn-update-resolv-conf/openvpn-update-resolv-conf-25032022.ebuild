# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1 tmpfiles

COMMIT="2485e9d"

DESCRIPTION="Updates DNS settings are pushed by the OpenVPN server"
HOMEPAGE="https://github.com/alfredopalhares/openvpn-update-resolv-conf"
SRC_URI="https://api.github.com/repos/alfredopalhares/${PN}/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-dns/openresolv
	net-vpn/openvpn"

S="${WORKDIR}/alfredopalhares-${PN}-${COMMIT}"

DOC_CONTENTS="Add the following lines to your client configuration:\\n
script-security 2\\n
up /usr/bin/update-resolv-conf\\n
down /usr/bin/update-resolv-conf\\n
down-pre\\n
Adjust ACLs for openvpn user:\\n
setfacl -Rm u:openvpn:rwx /run/resolvconf\\n
setfacl -m u:openvpn:rw /etc/resolv.conf\\n\\n"

src_install() {
	default

	newbin update-resolv-conf.sh update-resolv-conf
	newbin update-systemd-network.sh update-systemd-network
	newbin update-systemd-resolve.sh update-systemd-resolve
	newtmpfiles "${FILESDIR}"/openvpn-update-resolv-conf.tmpfile openvpn-update-resolv-conf.conf

	readme.gentoo_create_doc
}

pkg_postinst() {
	tmpfiles_process openvpn-update-resolv-conf.conf
	readme.gentoo_print_elog
}
