# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Popup menus for tmux to help with managing your environment"
HOMEPAGE="https://github.com/jaclu/tmux-menus"
EGIT_REPO_URI="https://github.com/jaclu/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-menus
	doins -r items scripts templates tools menus.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-menus/items{,/external_tools,/help,/hints,/odd_chars} \
		/usr/share/tmux-plugins/tmux-menus/scripts/act_{choose_tree,clear_screen,describe_key,display_char}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{break_pane,change_prefix}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/external_dialog_{handle,trigger}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/floating_pane_{helpers,switch}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{kill_other_windows,list-sessions,menu_handling}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/{plugin_init,reload_conf,update_custom_inventory}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/relocate_{pane,window}.sh \
		/usr/share/tmux-plugins/tmux-menus/scripts/utils/std_alone_log.sh \
		/usr/share/tmux-plugins/tmux-menus/templates/custom_{index_template,item_template}.sh \
		/usr/share/tmux-plugins/tmux-menus/tools/{dbg_vars,plugins,profiling-test,public_ip}.sh \
		/usr/share/tmux-plugins/tmux-menus/tools/{show_config,src_env}.sh \
		/usr/share/tmux-plugins/tmux-menus/menus.tmux
}
