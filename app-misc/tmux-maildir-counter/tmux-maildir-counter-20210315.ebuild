# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="68136a8020815f99eeba88bc0aae807a465e0e29"

DESCRIPTION="Plugin that counts files on a specific mail directory"
HOMEPAGE="https://github.com/tmux-plugins/tmux-maildir-counter"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-maildir-counter
	doins maildir_counter.tmux
	fperms +x /usr/share/tmux-plugins/tmux-maildir-counter/maildir_counter.tmux
}
