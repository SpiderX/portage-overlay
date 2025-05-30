# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Plug and play battery percentage and icon indicator for Tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-battery"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux
	|| ( app-misc/jq sys-power/acpi sys-power/upower )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-battery
	doins -r scripts battery.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-battery/scripts/battery_{graph,icon,percentage,remain}.sh \
		/usr/share/tmux-plugins/tmux-battery/scripts/battery_status_{b,f}g.sh \
		/usr/share/tmux-plugins/tmux-battery/battery.tmux
}
