# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils unpacker

BASE_URI="packages.microsoft.com/debian/12/prod/pool/main/m"

DESCRIPTION="Microsoft SQL Server Tools for Linux"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/tools/overview-sql-tools"
SRC_URI="amd64? ( https://${BASE_URI}/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_amd64.deb )
	arm64? ( https://${BASE_URI}/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_arm64.deb )"
S="${WORKDIR}"

LICENSE="BSD Microsoft-TOOLS"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror"

RDEPEND="dev-db/msodbcsql:18
	dev-db/unixODBC"

QA_PREBUILT="usr/bin/sqlbcp
	usr/bin/sqlcmd"

src_install() {
	dobin opt/mssql-tools"${PV%%.*}"/bin/sqlcmd
	# conflict with dev-libs/boost[tools]
	newbin opt/mssql-tools"${PV%%.*}"/bin/bcp sqlbcp

	insinto /usr/share/resources/en_US
	doins opt/mssql-tools"${PV%%.*}"/share/resources/en_US/BatchParserGrammar.{dfa,llr} \
		opt/mssql-tools"${PV%%.*}"/share/resources/en_US/bcp.rll \
		opt/mssql-tools"${PV%%.*}"/share/resources/en_US/SQLCMD.rll

	pax-mark m "${ED}"/usr/bin/sql{bcp,cmd}
}
