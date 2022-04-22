# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils systemd unpacker xdg

DESCRIPTION="AWS VPN Client"
HOMEPAGE="https://aws.amazon.com/vpn/"
SRC_URI="https://d20adtppz83p9s.cloudfront.net/GTK/${PV}/${PN}_amd64.deb"

LICENSE="Apache-2.0 GPL-1 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

RDEPEND="app-crypt/mit-krb5
	dev-util/lttng-ust
	sys-libs/zlib:0="
BDEPEND="sys-apps/fix-gnustack"

QA_PREBUILT="opt/awsvpnclient/AWS*
	opt/awsvpnclient/System.Native.so
	opt/awsvpnclient/libhostpolicy.so
	opt/awsvpnclient/System.Net.Security.Native.so
	opt/awsvpnclient/libhostfxr.so
	opt/awsvpnclient/System.Net.Http.Native.so
	opt/awsvpnclient/System.Security.Cryptography.Native.OpenSsl.so
	opt/awsvpnclient/Service/ACVC.GTK.Service
	opt/awsvpnclient/Service/System.Native.so
	opt/awsvpnclient/Service/libhostpolicy.so
	opt/awsvpnclient/Service/System.Net.Security.Native.so
	opt/awsvpnclient/Service/libhostfxr.so
	opt/awsvpnclient/Service/System.Net.Http.Native.so
	opt/awsvpnclient/Service/System.Security.Cryptography.Native.OpenSsl.so
	opt/awsvpnclient/Service/System.IO.Compression.Native.so
	opt/awsvpnclient/System.IO.Compression.Native.so"
QA_FLAGS_IGNORED="opt/awsvpnclient/AWS*
	opt/awsvpnclient/libcoreclrtraceptprovider.so
	opt/awsvpnclient/libcoreclr.so
	opt/awsvpnclient/System.Native.so
	opt/awsvpnclient/libmscordaccore.so
	opt/awsvpnclient/libmscordbi.so
	opt/awsvpnclient/libdbgshim.so
	opt/awsvpnclient/libhostpolicy.so
	opt/awsvpnclient/System.Globalization.Native.so
	opt/awsvpnclient/System.Net.Security.Native.so
	opt/awsvpnclient/createdump
	opt/awsvpnclient/libhostfxr.so
	opt/awsvpnclient/System.Net.Http.Native.so
	opt/awsvpnclient/System.Security.Cryptography.Native.OpenSsl.so
	opt/awsvpnclient/SQLite.Interop.dll
	opt/awsvpnclient/Service/libcoreclrtraceptprovider.so
	opt/awsvpnclient/Service/ACVC.GTK.Service
	opt/awsvpnclient/Service/Resources/openvpn/acvc-openvpn
	opt/awsvpnclient/Service/libcoreclr.so
	opt/awsvpnclient/Service/System.Native.so
	opt/awsvpnclient/Service/libmscordaccore.so
	opt/awsvpnclient/Service/libmscordbi.so
	opt/awsvpnclient/Service/libdbgshim.so
	opt/awsvpnclient/Service/libhostpolicy.so
	opt/awsvpnclient/Service/System.Globalization.Native.so
	opt/awsvpnclient/Service/System.Net.Security.Native.so
	opt/awsvpnclient/Service/createdump
	opt/awsvpnclient/Service/libhostfxr.so
	opt/awsvpnclient/Service/System.Net.Http.Native.so
	opt/awsvpnclient/Service/System.Security.Cryptography.Native.OpenSsl.so
	opt/awsvpnclient/Service/SQLite.Interop.dll
	opt/awsvpnclient/Service/libclrjit.so
	opt/awsvpnclient/Service/System.IO.Compression.Native.so
	opt/awsvpnclient/libclrjit.so
	opt/awsvpnclient/System.IO.Compression.Native.so"

S="${WORKDIR}"

PATCHES=( "${FILESDIR}"/awsvpnclient.desktop.patch )

src_install() {
	fix-gnustack -f opt/awsvpnclient/Service/Resources/openvpn/acvc-openvpn \
		> /dev/null || die "removing execstack flag failed"

	newicon -s 64 usr/share/pixmaps/acvc-64.png acvc-64.png
	dosym ../icons/hicolor/64x64/apps/acvc-64.png \
		/usr/share/pixmaps/acvc-64.png

	domenu usr/share/applications/awsvpnclient.desktop

	insinto /opt/awsvpnclient
	doins -r opt/awsvpnclient/.

	fperms +x /opt/awsvpnclient/{'AWS VPN Client',createdump} \
		/opt/awsvpnclient/Service/{ACVC.GTK.Service,createdump} \
		/opt/awsvpnclient/Service/Resources/openvpn/{acvc-openvpn,configure-dns}

	dodir /opt/bin
	dosym ../awsvpnclient/AWS\ VPN\ Client opt/bin/AWS\ VPN\ Client

	systemd_dounit etc/systemd/system/awsvpnclient.service

	pax-mark -m "${ED}"/opt/awsvpnclient/AWS\ VPN\ Client
}
