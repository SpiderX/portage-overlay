# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-info toolchain-funcs

DESCRIPTION="Tool which monitors for inotify events and executes script"
HOMEPAGE="https://github.com/quitesimpleorg/adhocify"
EGIT_REPO_URI="https://github.com/quitesimpleorg/${PN}.git"

LICENSE="ISC"
SLOT="0"

CONFIG_CHECK="~INOTIFY_USER"

src_prepare() {
	default

	sed -i  -e '/CFLAGS/s|=|+=|' \
		-e '/(CC) adhocify.c -g/s|$(CFLAGS)|$(CFLAGS) $(LDFLAGS)|' \
		Makefile || die "sed failed for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	dobin adhocify
}
