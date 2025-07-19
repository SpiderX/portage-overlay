# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="JSON parser designed for maximum convenience within the shell"
HOMEPAGE="http://kmkeen.com/jshon/ https://github.com/keenerd/jshon"
EGIT_REPO_URI="https://github.com/keenerd/${PN}.git"

LICENSE="MIT"
SLOT="0"

DEPEND="dev-libs/jansson"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)"
}
