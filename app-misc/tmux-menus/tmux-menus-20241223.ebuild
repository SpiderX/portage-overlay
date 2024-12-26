# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="0bc4c35064e2ee785e77c6a531481e15f6ea4e7f"

DESCRIPTION="Popup menus for tmux to help with managing your environment"
HOMEPAGE="https://github.com/jaclu/tmux-menus"
SRC_URI="https://github.com/jaclu/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-menus
	doins -r items scripts menus.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-menus/items{,/extras} \
		/usr/share/tmux-plugins/tmux-menus/scripts/{break_pane,change_prefix,dialog_handling}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/external_dialog_{handle,trigger}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{kill_other_windows,move_menu,plugins}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{public_ip,reload_conf,show_config}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{reload_conf.sh,spotify-now-playing} \
		/usr/share/tmux-plugins/tmux-menus/scripts/relocate_{pane,param_check,window}.sh \
		/usr/share/tmux-plugins/tmux-menus/menus.tmux
}
