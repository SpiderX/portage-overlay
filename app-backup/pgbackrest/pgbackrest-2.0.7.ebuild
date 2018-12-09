# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

MY_PV="$(ver_rs 2 '')"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="https://pgbackrest.org https://github.com/pgbackrest/pgbackrest"
SRC_URI="https://github.com/${PN}/${PN}/archive/release/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="libressl"

DEPEND="dev-lang/perl:0=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-release-${MY_PV}/src"

src_prepare() {
	default

	# Respect FLAGS, remove std99
	sed -i -e '/CFLAGS /s/= $(CINCLUDE) $(CSTD) $(COPT)/+= $(CINCLUDE)/' \
		-e '/LDFLAGS /s/=/+=/' \
		Makefile || die "sed failed for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}
