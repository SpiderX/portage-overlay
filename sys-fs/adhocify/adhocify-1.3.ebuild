# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info toolchain-funcs

DESCRIPTION="Tool which monitors for inotify events and executes script"
HOMEPAGE="https://github.com/quitesimpleorg/adhocify"
SRC_URI="https://github.com/quitesimpleorg/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
