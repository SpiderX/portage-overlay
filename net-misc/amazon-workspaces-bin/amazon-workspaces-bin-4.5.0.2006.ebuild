# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Amazon Workspace Client"
HOMEPAGE="https://clients.amazonworkspaces.com"
SRC_URI="https://d3nt0h4h6pmmc4.cloudfront.net/workspacesclient_focal_amd64.deb -> workspacesclient-${PV}_amd64.deb"

LICENSE="all-rights-reserved Apache-2.0 GPL-2 MIT no-source-code"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="dev-libs/hiredis:0/0.14
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4
	x11-libs/gtk+:3"

QA_PREBUILT="opt/workspacesclient/libpcoip_core.so
	opt/workspacesclient/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/workspacesclient/libSystem.Native.so
	opt/workspacesclient/workspacesclient
	opt/workspacesclient/libSystem.IO.Compression.Native.so
	opt/workspacesclient/createdump
	opt/workspacesclient/libmscordaccore.so
	opt/workspacesclient/libhostfxr.so
	opt/workspacesclient/libSystem.Globalization.Native.so
	opt/workspacesclient/libcoreclrtraceptprovider.so
	opt/workspacesclient/libclrjit.so
	opt/workspacesclient/libdbgshim.so
	opt/workspacesclient/libmscordbi.so
	opt/workspacesclient/libcoreclr.so
	opt/workspacesclient/libSystem.Net.Security.Native.so
	opt/workspacesclient/libhostpolicy.so"

S="${WORKDIR}"

src_prepare() {
	default

	rm -rf opt/workspacesclient/Licenses || die "remove Licenses"
}

src_install() {
	doicon usr/share/pixmaps/com.amazon.workspaces.svg usr/share/pixmaps/com.amazon.workspaces.svg
	domenu usr/share/applications/workspacesclient.desktop

	insinto /opt
	cp -a opt/workspacesclient "${ED}"/opt || die "cp failed"

	dosym ../../opt/workspacesclient/workspacesclient /usr/bin/workspacesclient

	pax-mark -m "${ED}"/opt/workspacesclient/workspacesclient
}
