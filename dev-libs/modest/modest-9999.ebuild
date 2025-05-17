# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Fast HTML renderer"
HOMEPAGE="https://github.com/lexborisov/modest"
EGIT_REPO_URI="https://github.com/lexborisov/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS -Wno-variadic-macros -ffat-lto-objects" \
		prefix=/usr PROJECT_INSTALL_LIBRARY="$(get_libdir)" \
		MODEST_LDFLAGS="-Wl,-soname,lib${PN}-${PV:0:1}.so"
}

src_install() {
	einstalldocs
	emake prefix="${ED}"/usr PROJECT_INSTALL_LIBRARY="$(get_libdir)" install
}
