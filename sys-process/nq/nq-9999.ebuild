# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 shell-completion toolchain-funcs

DESCRIPTION="Unix command line queue utility"
HOMEPAGE="https://github.com/leahneukirchen/nq"
EGIT_REPO_URI="https://github.com/leahneukirchen/${PN}.git"

LICENSE="public-domain"
SLOT="0"

DOCS=( {NEWS,README}.md )

src_prepare() {
	default

	# Respect CFLAGS, remove options
	sed -i '/CFLAGS/s/=-g -Wall -O2/+=-Wall/' Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_test() {
	emake check
}

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="/usr" install
	dozshcomp _nq
}
