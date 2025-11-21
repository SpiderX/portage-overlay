# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 git-r3 meson

DESCRIPTION="A simple serial device I/O tool"
HOMEPAGE="https://github.com/tio/tio"
EGIT_REPO_URI="https://github.com/tio/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"

RDEPEND="dev-libs/inih"

src_configure() {
	local emesonargs=(
		-Dbashcompletiondir="$(get_bashcompdir)"
	)
	meson_src_configure
}
