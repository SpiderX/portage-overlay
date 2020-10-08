# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker

DESCRIPTION="Automates SQL Server database development tasks"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/tools/sqlpackage"
SRC_URI="https://download.microsoft.com/download/5/d/1/5d1fc310-e111-4856-946a-c945a6d25708/${PN}-linux-x64-en-US-${PV}.zip"

LICENSE="Microsoft-TOOLS"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="bindist mirror"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"

QA_PREBUILT="/opt/sqlpackage/sqlpackage
	opt/sqlpackage/System.Native.so
	opt/sqlpackage/System.Security.Cryptography.Native.OpenSsl.so
	opt/sqlpackage/System.Net.Http.Native.so
	opt/sqlpackage/libhostfxr.so
	opt/sqlpackage/System.Net.Security.Native.so
	opt/sqlpackage/libhostpolicy.so
	opt/sqlpackage/System.IO.Compression.Native.so"

src_install() {
	einstalldocs

	insinto /opt/sqlpackage
	doins -r *.{a,dll,json,md,pdb,so}
	exeinto /opt/sqlpackage
	doexe createdump sqlpackage

	dodir /opt/bin
	dosym ../sqlpackage/sqlpackage opt/bin/sqlpackage
	dosym ../sqlpackage/createdump opt/bin/createdump

	pax-mark m "${ED}"/opt/sqlpackage/{createdump,sqlpackage}
}
