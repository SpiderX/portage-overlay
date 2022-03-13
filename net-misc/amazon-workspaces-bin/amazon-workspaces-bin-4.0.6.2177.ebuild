# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Amazon Workspace Client"
HOMEPAGE="https://clients.amazonworkspaces.com"
SRC_URI="https://d3nt0h4h6pmmc4.cloudfront.net/workspacesclient_amd64.deb -> workspacesclient-${PV}_amd64.deb"

LICENSE="all-rights-reserved Apache-2.0 GPL-2 MIT no-source-code"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="net-libs/libsoup:2.4
	net-libs/webkit-gtk:4
	x11-libs/gtk+:3"

QA_PREBUILT="opt/workspacesclient/workspacesclient
		opt/workspacesclient/libpcoip_core.so
		opt/workspacesclient/libhostpolicy.so
		opt/workspacesclient/libhostfxr.so
		opt/workspacesclient/System.Security.Cryptography.Native.OpenSsl.so
		opt/workspacesclient/System.Net.Security.Native.so
		opt/workspacesclient/System.Net.Http.Native.so
		opt/workspacesclient/System.Native.so
		opt/workspacesclient/System.IO.Compression.Native.so"

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
