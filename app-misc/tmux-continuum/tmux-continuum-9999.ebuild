# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

inherit git-r3

DESCRIPTION="Continuous saving of tmux environment"
HOMEPAGE="https://github.com/tmux-plugins/tmux-continuum"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	app-misc/tmux-resurrect
	sys-process/procps"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-continuum
	doins -r scripts continuum.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-continuum/scripts/handle_tmux_automatic_start/osx_{dis,en}able.sh \
		/usr/share/tmux-plugins/tmux-continuum/scripts/handle_tmux_automatic_start/osx_{iterm,terminal}_start_tmux.sh \
		/usr/share/tmux-plugins/tmux-continuum/scripts/handle_tmux_automatic_start.sh \
		/usr/share/tmux-plugins/tmux-continuum/scripts/check_tmux_version.sh \
		/usr/share/tmux-plugins/tmux-continuum/scripts/continuum_{restore,save}.sh \
		/usr/share/tmux-plugins/tmux-continuum/continuum.tmux
}
