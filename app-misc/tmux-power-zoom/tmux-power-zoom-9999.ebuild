# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jaclu/${PN}.git"

inherit git-r3

DESCRIPTION="Zoom pane to separate window, and unzoom it back"
HOMEPAGE="https://github.com/jaclu/tmux-power-zoom"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-power-zoom
	doins -r scripts power-zoom.tmux
	fperms +x /usr/share/tmux-plugins/tmux-power-zoom/scripts/power_zoom.sh \
		/usr/share/tmux-plugins/tmux-power-zoom/power-zoom.tmux
}
