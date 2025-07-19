# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 savedconfig toolchain-funcs

DESCRIPTION="A simple command line pastebin designed to be used together with ssh"
HOMEPAGE="https://github.com/SpiderX/keening"
EGIT_REPO_URI="https://github.com/SpiderX/${PN}.git"

LICENSE="BSD"
SLOT="0"

RESTRICT="mirror"

DOCS=( README.md )

src_prepare() {
	default

	# respect FLAGS
	sed -i  -e '/CFLAGS/s|= -g|+=|' \
		-e '/OBJECTS) -Wal/s| -Wall| $(LDFLAGS) -Wall|' \
			Makefile || die "sed failed for Makefile"

	restore_config config.h
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
	save_config config.h
}
