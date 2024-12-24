# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Easy logging and screen capturing for Tmux"
HOMEPAGE="https://github.com/tmux-plugins/tmux-logging"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-misc/tmux"

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugins/tmux-logging
	doins -r scripts logging.tmux
	fperms -R +x /usr/share/tmux-plugins/tmux-logging/scripts/check_tmux_version.sh \
		/usr/share/tmux-plugins/tmux-logging/scripts/{clear,save_complete}_history.sh \
		/usr/share/tmux-plugins/tmux-logging/scripts/screen_capture.sh \
		/usr/share/tmux-plugins/tmux-logging/scripts/{start,toggle}_logging.sh \
		/usr/share/tmux-plugins/tmux-logging/logging.tmux
}
