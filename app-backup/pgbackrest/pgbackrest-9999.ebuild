# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Reliable PostgreSQL Backup & Restore"
HOMEPAGE="https://pgbackrest.org https://github.com/pgbackrest/pgbackrest"
SRC_URI=""

LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE="libressl"

DEPEND="dev-lang/perl:0=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

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
