# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Plug and play battery percentage and icon indicator for Tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-battery"
EGIT_REPO_URI="https://github.com/tmux-plugins/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux
	|| ( app-misc/jq sys-power/acpi sys-power/upower )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-battery
	doins -r scripts battery.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-battery/scripts/battery_{graph,percentage,remain}.sh \
		/usr/share/tmux-plugins/tmux-battery/scripts/battery_charging_watts.sh \
		/usr/share/tmux-plugins/tmux-battery/scripts/battery_icon{,_charge,_status}.sh \
		/usr/share/tmux-plugins/tmux-battery/scripts/battery_color{,_charge,_status}.sh \
		/usr/share/tmux-plugins/tmux-battery/battery{,_enabled}.tmux
}
