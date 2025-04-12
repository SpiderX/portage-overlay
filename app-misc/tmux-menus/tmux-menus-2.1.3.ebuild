# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Popup menus for tmux to help with managing your environment"
HOMEPAGE="https://github.com/jaclu/tmux-menus"
SRC_URI="https://github.com/jaclu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-menus
	doins -r items scripts templates menus.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-menus/items{,/external_tools,/help,/hints} \
		/usr/share/tmux-plugins/tmux-menus/scripts/act_{choose_tree,display_char}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{break_pane,change_prefix,dialog_handling}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/external_dialog_{handle,trigger}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{kill_other_windows,plugins}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{public_ip,show_cmd,show_config}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{reload_conf,update_custom_inventory}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/relocate_{pane,param_check,window}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/utils/{dbg_vars,plugin_init}.sh \
		/usr/share/tmux-plugins/tmux-menus/templates/custom_{index_template,item_template}.sh \
		/usr/share/tmux-plugins/tmux-menus/menus.tmux
}
