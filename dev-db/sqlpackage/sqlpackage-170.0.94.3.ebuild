# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils unpacker

DESCRIPTION="Automates SQL Server database development tasks"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver17"
SRC_URI="https://download.microsoft.com/download/ea206d61-b601-43e5-8fa1-3e0cf42954b8/${PN}-linux-x64-en-${PV}.zip"
S="${WORKDIR}"

LICENSE="Microsoft-TOOLS"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="app-crypt/mit-krb5
	dev-util/lttng-ust:0="
BDEPEND="app-arch/unzip"

QA_PREBUILT="opt/sqlpackage/libclrgc.so
	opt/sqlpackage/libSystem.Net.Security.Native.so
	opt/sqlpackage/libcoreclrtraceptprovider.so
	opt/sqlpackage/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/sqlpackage/libcoreclr.so
	opt/sqlpackage/libmscordaccore.so
	opt/sqlpackage/libmscordbi.so
	opt/sqlpackage/sqlpackage
	opt/sqlpackage/libhostpolicy.so
	opt/sqlpackage/createdump
	opt/sqlpackage/libSystem.Native.so
	opt/sqlpackage/libhostfxr.so
	opt/sqlpackage/libSystem.IO.Compression.Native.so
	opt/sqlpackage/libSystem.Globalization.Native.so
	opt/sqlpackage/libclrjit.so"
QA_FLAGS_IGNORED="opt/sqlpackage/libclrgc.so
	opt/sqlpackage/libSystem.Net.Security.Native.so
	opt/sqlpackage/libcoreclrtraceptprovider.so
	opt/sqlpackage/libSystem.Security.Cryptography.Native.OpenSsl.so
	opt/sqlpackage/libcoreclr.so
	opt/sqlpackage/libmscordaccore.so
	opt/sqlpackage/libmscordbi.so
	opt/sqlpackage/sqlpackage
	opt/sqlpackage/libhostpolicy.so
	opt/sqlpackage/createdump
	opt/sqlpackage/libSystem.Native.so
	opt/sqlpackage/libhostfxr.so
	opt/sqlpackage/libSystem.IO.Compression.Native.so
	opt/sqlpackage/libSystem.Globalization.Native.so
	opt/sqlpackage/libclrjit.so"

src_install() {
	einstalldocs

	insinto /opt/sqlpackage
	doins -r *.{dll,json,pdb,so}
	exeinto /opt/sqlpackage
	doexe createdump sqlpackage

	dodir /opt/bin
	dosym ../sqlpackage/sqlpackage opt/bin/sqlpackage
	dosym ../sqlpackage/createdump opt/bin/createdump

	pax-mark m "${ED}"/opt/sqlpackage/{createdump,sqlpackage}
}
