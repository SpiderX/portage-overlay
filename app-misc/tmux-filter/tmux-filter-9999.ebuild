# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/MaximilianGaedig/${PN}.git"

inherit git-r3

DESCRIPTION="Filter logs by some text or pattern"
HOMEPAGE="https://github.com/MaximilianGaedig/tmux-filter"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-filter
	doins -r scripts filter.tmux
	fperms +x /usr/share/tmux-plugins/tmux-filter/scripts/live-filter.bash \
		/usr/share/tmux-plugins/tmux-filter/filter.tmux
}
