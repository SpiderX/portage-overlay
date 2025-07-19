# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="ver_${PV}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="PostgreSQL extension for data reorganization"
HOMEPAGE="https://github.com/reorg/pg_repack"
SRC_URI="https://github.com/reorg/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="client debug static-libs"
REQUIRED_USE="debug? ( client ) client? ( static-libs )"

RDEPEND="client? ( dev-db/postgresql:*[static-libs?] )"
DEPEND="dev-db/postgresql:*[static-libs?]"

src_prepare() {
	default

	# don't build client by default
	if ! use client ; then
		sed -i '/SUBDIRS =/s/bin //' Makefile \
			|| die "sed failed for Makefile"
	fi
}

src_compile() {
	emake USE_PGXS=1 DDEBUG_REPACK="$(usex debug 1 '')"
}
