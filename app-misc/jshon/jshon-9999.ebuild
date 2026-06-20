# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="JSON parser designed for maximum convenience within the shell"
HOMEPAGE="https://github.com/keenerd/jshon"
EGIT_REPO_URI="https://github.com/keenerd/${PN}.git"

LICENSE="MIT"
SLOT="0"

DEPEND="dev-libs/jansson:0="
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)"
}
