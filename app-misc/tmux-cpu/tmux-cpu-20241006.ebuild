# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="bcb110d754ab2417de824c464730c412a3eb2769"

DESCRIPTION="Plug and play cpu percentage and icon indicator for Tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-cpu"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lm-sensors nvidia"

RDEPEND="app-misc/tmux
	app-admin/sysstat
	sys-process/procps
	lm-sensors? ( sys-apps/lm-sensors:= )
	nvidia? ( x11-drivers/nvidia-drivers:= )"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-cpu
	doins -r scripts cpu.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-cpu/scripts/{cpu,gpu,gram,ram}_{b,f}g_color.sh \
			/usr/share/tmux-plugins/tmux-cpu/scripts/{cpu,gpu,gram,ram}_{icon,percentage}.sh \
			/usr/share/tmux-plugins/tmux-cpu/scripts/{cpu,gpu}_temp{,_bg_color,_fg_color,_icon}.sh \
			/usr/share/tmux-plugins/tmux-cpu/cpu.tmux
}
