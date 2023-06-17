# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 meson

DESCRIPTION="A simple serial device I/O tool"
HOMEPAGE="https://github.com/tio/tio"
SRC_URI="https://github.com/tio/tio/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/inih"

src_configure() {
	local emesonargs=(
		-Dbashcompletiondir="$(get_bashcompdir)"
	)
	meson_src_configure
}
