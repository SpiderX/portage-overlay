# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Feh/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Minimize caching effects for applications"
HOMEPAGE="https://github.com/Feh/nocache"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr/" LIBDIR="$(get_libdir)" install
}
