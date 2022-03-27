# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://git.sr.ht/~iank/evhz"

inherit git-r3 flag-o-matic toolchain-funcs

DESCRIPTION="Mouse refresh rate under evdev"
HOMEPAGE="https://git.sr.ht/~iank/evhz"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

src_compile() {
	append-cflags
	append-ldflags
	"$(tc-getCC)" ${CFLAGS} ${LDFLAGS} -o evhz evhz.c || die "gcc failed"
}

src_install() {
	einstalldocs
	dobin evhz
}
