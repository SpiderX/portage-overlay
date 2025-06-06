# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

URI="packages.microsoft.com/debian/12/prod/pool/main/m"

DESCRIPTION="Microsoft ODBC Driver for SQL Server"
HOMEPAGE="https://learn.microsoft.com/en-us/sql/connect/odbc/microsoft-odbc-driver-for-sql-server"
SRC_URI="amd64? ( https://${URI}/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_amd64.deb )
	arm64? ( https://${URI}/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_arm64.deb )"
S="${WORKDIR}"

LICENSE="Microsoft-ODBC"
SLOT="${PV%%.*}"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror"

RDEPEND="dev-db/unixODBC
	virtual/krb5"

DOCS=( usr/share/doc/msodbcsql18/RELEASE_NOTES )

QA_PREBUILT="usr/lib64/libmsodbcsql-${PV%.*.*}.so.${PV#*.*.}"

src_prepare() {
	default

	# change lib path
	sed -i '/Driver/s|opt/microsoft/msodbcsql[0-9]*|usr|' \
		opt/microsoft/msodbcsql"${PV%%.*}"/etc/odbcinst.ini \
		|| die "sed failed for odbcinst.ini"
}

src_install() {
	einstalldocs

	insinto /usr/share/"${PN}-${SLOT}"
	doins opt/microsoft/msodbcsql"${PV%%.*}"/etc/odbcinst.ini

	doheader opt/microsoft/msodbcsql"${PV%%.*}"/include/msodbcsql.h
	dolib.so opt/microsoft/msodbcsql"${PV%%.*}"/lib64/libmsodbcsql-"${PV%.*.*}".so."${PV#*.*.}"
	dosym libmsodbcsql-"${PV%.*.*}".so."${PV#*.*.}" usr/lib64/libmsodbcsql-"${PV%%.*}".so

	insinto /usr/share/resources/en_US
	doins opt/microsoft/msodbcsql"${PV%%.*}"/share/resources/en_US/msodbcsqlr"${PV%%.*}".rll
}

pkg_config() {
	local driver drivers
	driver="ODBC Driver ${SLOT} for SQL Server"
	drivers="$(/usr/bin/odbcinst -q -d)"

	if echo "$drivers" | grep -vq "^\[$driver\]$" ; then
		ebegin "Installing ${driver}"
		/usr/bin/odbcinst -i -d -f /usr/share/"${PN}-${SLOT}"/odbcinst.ini
		eend $? "Failed to install ${driver}"
	else
		einfo "Skipping already installed ${driver}"
	fi
}

pkg_postinst() {
	elog "If this is a new install, please run the following command"
	elog "to configure the MSSQL ODBC driver:"
	elog "emerge --config =${CATEGORY}/${PF}"
}
