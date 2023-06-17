# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tio/${PN}.git"

inherit bash-completion-r1 git-r3 meson

DESCRIPTION="A simple serial device I/O tool"
HOMEPAGE="https://github.com/tio/tio"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/inih"

src_configure() {
	local emesonargs=(
		-Dbashcompletiondir="$(get_bashcompdir)"
	)
	meson_src_configure
}
