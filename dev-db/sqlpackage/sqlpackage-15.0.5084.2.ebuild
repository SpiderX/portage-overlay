# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker

DESCRIPTION="Automates SQL Server database development tasks"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver15"
SRC_URI="https://download.microsoft.com/download/0/2/0/020aa2fa-f3f2-41ba-bacd-ff15557890d3/${PN}-linux-x64-en-US-${PV}.zip"

LICENSE="Microsoft-TOOLS"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="app-crypt/mit-krb5
	dev-util/lttng-ust:0="
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

QA_PREBUILT="opt/sqlpackage/sqlpackage
	opt/sqlpackage/System.Native.so
	opt/sqlpackage/System.Security.Cryptography.Native.OpenSsl.so
	opt/sqlpackage/System.Net.Http.Native.so
	opt/sqlpackage/libhostfxr.so
	opt/sqlpackage/System.Net.Security.Native.so
	opt/sqlpackage/libhostpolicy.so
	opt/sqlpackage/System.IO.Compression.Native.so"
QA_FLAGS_IGNORED="opt/sqlpackage/libmscordaccore.so
	opt/sqlpackage/libdbgshim.so
	opt/sqlpackage/System.Globalization.Native.so
	opt/sqlpackage/libcoreclr.so
	opt/sqlpackage/libcoreclrtraceptprovider.so
	opt/sqlpackage/libclrjit.so
	opt/sqlpackage/libmscordbi.so
	opt/sqlpackage/createdump"

src_install() {
	einstalldocs

	insinto /opt/sqlpackage
	doins -r ./*.{a,dll,json,md,pdb,so}
	exeinto /opt/sqlpackage
	doexe createdump sqlpackage

	dodir /opt/bin
	dosym ../sqlpackage/sqlpackage opt/bin/sqlpackage
	dosym ../sqlpackage/createdump opt/bin/createdump

	pax-mark m "${ED}"/opt/sqlpackage/{createdump,sqlpackage}
}
