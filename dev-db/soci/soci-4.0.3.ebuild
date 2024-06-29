# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Database access library for C++"
HOMEPAGE="https://github.com/SOCI/soci"
SRC_URI="https://github.com/SOCI/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="firebird mysql odbc oracle postgres sqlite static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="dev-libs/boost:=
	firebird? ( dev-db/firebird )
	mysql? ( dev-db/mysql-connector-c:0= )
	odbc? ( dev-db/unixODBC )
	oracle? ( dev-db/oracle-instantclient:= )
	postgres? ( dev-db/postgresql:= )
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DSOCI_CXX11=ON
		-DSOCI_STATIC="$(usex static-libs)"
		-DSOCI_TESTS="$(usex test)"
	)

	cmake_src_configure
}
