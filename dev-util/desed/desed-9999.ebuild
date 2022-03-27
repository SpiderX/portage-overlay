# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

EGIT_REPO_URI="https://github.com/SoptikHa2/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Debugger for Sed"
HOMEPAGE="https://github.com/SoptikHa2/desed"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
