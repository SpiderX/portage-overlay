# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/nunojpg/${PN}.git"

inherit flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="Ntrip Version 2.0 Command Line Server"
HOMEPAGE="https://github.com/nunojpg/ntripserver"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DOCS=( README )

src_prepare() {
	default

	sed -i '/-DNDEBUG/s|-O3 ||' makefile || die "sed failed"
}

src_compile() {
	append-cflags
	append-ldflags

	emake CC="$(tc-getCC)" OPTS="${CFLAGS} ${LDFLAGS}"
}

src_install() {
	einstalldocs
	dobin ntripserver

	newinitd "${FILESDIR}"/ntripserver.initd ntripserver
	newconfd "${FILESDIR}"/ntripserver.confd ntripserver
}
