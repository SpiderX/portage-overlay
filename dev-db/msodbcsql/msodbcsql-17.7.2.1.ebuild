# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Microsoft ODBC Driver for SQL Server"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/connect/odbc/microsoft-odbc-driver-for-sql-server?view=sql-server-ver15"
SRC_URI="https://packages.microsoft.com/debian/10/prod/pool/main/m/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_amd64.deb"

LICENSE="Microsoft-ODBC"
SLOT="17"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="bindist mirror"

RDEPEND="dev-db/unixODBC
	virtual/krb5"

S="${WORKDIR}"

DOCS=( usr/share/doc/msodbcsql17/RELEASE_NOTES )

QA_PREBUILT="usr/lib64/libmsodbcsql-17.7.so.2.1"

src_prepare() {
	default

	# Change lib path
	sed -i '/Driver/s|opt/microsoft/msodbcsql17|usr|' \
		opt/microsoft/msodbcsql17/etc/odbcinst.ini \
		|| die "sed failed for odbcinst.ini"
}

src_install() {
	einstalldocs

	insinto /etc/unixODBC
	doins opt/microsoft/msodbcsql17/etc/odbcinst.ini

	doheader opt/microsoft/msodbcsql17/include/msodbcsql.h
	dolib.so opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.7.so.2.1
	dosym libmsodbcsql-17.7.so.2.1 usr/lib64/libmsodbcsql-17.so

	insinto /usr/share/resources/en_US
	doins opt/microsoft/msodbcsql17/share/resources/en_US/msodbcsqlr17.rll
}
