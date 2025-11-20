# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop edo pax-utils readme.gentoo-r1 systemd unpacker xdg

DESCRIPTION="AWS VPN Client"
HOMEPAGE="https://aws.amazon.com/vpn/"
SRC_URI="https://d20adtppz83p9s.cloudfront.net/GTK/${PV}/${PN}_amd64.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="Apache-2.0 GPL-1 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="dev-util/lttng-ust-compat:0=
	virtual/zlib:0="

DOC_CONTENTS="Pakage expects to have /sbin/ip and /sbin/sysctl in the system.
You may need to create them:\\n
ln -s /bin/ip /sbin/ip\\n
ln -s /usr/sbin/sysctl /bin/sysctl\\n\\n"

QA_PREBUILT="opt/awsvpnclient/AWS*
	opt/awsvpnclient/libclrgc.so
	opt/awsvpnclient/libSystem.Net.Security.Native.so
	opt/awsvpnclient/libcoreclrtraceptprovider.so
	opt/awsvpnclient/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/awsvpnclient/libe_sqlite3.so
	opt/awsvpnclient/libcoreclr.so
	opt/awsvpnclient/libmscordaccore.so
	opt/awsvpnclient/libmscordbi.so
	opt/awsvpnclient/libhostpolicy.so
	opt/awsvpnclient/gtk_routing_table_utils.dylib
	opt/awsvpnclient/createdump
	opt/awsvpnclient/libSystem.Native.so
	opt/awsvpnclient/libhostfxr.so
	opt/awsvpnclient/libSystem.IO.Compression.Native.so
	opt/awsvpnclient/libSystem.Globalization.Native.so
	opt/awsvpnclient/Service/libclrgc.so
	opt/awsvpnclient/Service/libSystem.Net.Security.Native.so
	opt/awsvpnclient/Service/libcoreclrtraceptprovider.so
	opt/awsvpnclient/Service/ACVC.GTK.Service
	opt/awsvpnclient/Service/Resources/openvpn/openssl
	opt/awsvpnclient/Service/Resources/openvpn/libc.so
	opt/awsvpnclient/Service/Resources/openvpn/ld-musl-x86_64.so.1
	opt/awsvpnclient/Service/Resources/openvpn/acvc-openvpn
	opt/awsvpnclient/Service/Resources/openvpn/fips.so
	opt/awsvpnclient/Service/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/awsvpnclient/Service/libe_sqlite3.so
	opt/awsvpnclient/Service/libcoreclr.so
	opt/awsvpnclient/Service/libmscordaccore.so
	opt/awsvpnclient/Service/libmscordbi.so
	opt/awsvpnclient/Service/libhostpolicy.so
	opt/awsvpnclient/Service/gtk_routing_table_utils.dylib
	opt/awsvpnclient/Service/createdump
	opt/awsvpnclient/Service/libSystem.Native.so
	opt/awsvpnclient/Service/libhostfxr.so
	opt/awsvpnclient/Service/libSystem.IO.Compression.Native.so
	opt/awsvpnclient/Service/libSystem.Globalization.Native.so
	opt/awsvpnclient/Service/libclrjit.so
	opt/awsvpnclient/Service/gtk_routing_table_listener.dylib
	opt/awsvpnclient/libclrjit.so
	opt/awsvpnclient/gtk_routing_table_listener.dylib"

src_prepare() {
	default

	sed -i  -e '/Icon/s|.png||' \
		-e '/Categories/s|VPN;||' \
		usr/share/applications/awsvpnclient.desktop \
		|| die "sed failed for awsvpnclient.desktop"
}

src_install() {
	newicon -s 64 usr/share/pixmaps/acvc-64.png acvc-64.png
	dosym ../icons/hicolor/64x64/apps/acvc-64.png \
		/usr/share/pixmaps/acvc-64.png
	domenu usr/share/applications/awsvpnclient.desktop

	keepdir /var/log/aws-vpn-client

	insinto /opt/awsvpnclient
	edo cp -a opt/awsvpnclient "${ED}"/opt

	dodir /opt/bin
	dosym ../awsvpnclient/AWS\ VPN\ Client opt/bin/AWS\ VPN\ Client

	newinitd "${FILESDIR}"/awsvpnclient.initd awsvpnclient
	systemd_dounit etc/systemd/system/awsvpnclient.service

	pax-mark -m "${ED}"/opt/awsvpnclient/AWS\ VPN\ Client

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
